#!/usr/bin/env lua

---@alias github_ref_type 'tag' | 'branch'

---@class (exact) Args
---@field repo_name string The repository name.
---@field github_repo string The github repository (owner/repo_name).
---@field git_server_url string The github server's URL.
---@field git_ref string E.g. a tag or a commit sha.
---@field ref_type github_ref_type
---@field dependencies string[] List of LuaRocks package dependencies.
---@field test_dependencies string[] List of test suite dependencies.
---@field labels string[] List of labels to add to the project.
---@field copy_directories string[] List of directories to add to the project's copy_directories.
---@field summary string Package summary.
---@field detailed_description_lines string[] Detailed description (list of lines).
---@field template string|nil Path to a custom `extra.rockspec` template.
---@field upload boolean Whether to upload to LuaRocks.
---@field license string|nil License SPDX ID (optional).
---@field extra_luarocks_args string[] Legacy extra args, mapped to lux flags.
---@field extra_lux_args string[] Extra args passed to the lux command verbatim.
---@field github_event_path string|nil The path to the file on the runner that contains the full event webhook payload. For example, /github/workflow/event.json.
---@field is_debug boolean Whether to enable debug logging
---@field fail_on_duplicate boolean Whether to fail if the rock version has already been uploaded.

local OS = require('ltr.os')
local Lux = require('ltr.lux')
local Project = require('ltr.project')
local Release = require('ltr.release')
local json = require('dkjson')

---@param args Args
---@return string tmp_dir
local function mk_tmp_tree(args)
  return (OS.execute('mktemp -d', error, args.is_debug):gsub('\n', ''))
end

---@param project ProjectSource
local function write_generated_project(project)
  print('Generating lux.toml:')
  print(project.content)
  OS.write_file(project.directory .. '/lux.toml', project.content)
end

---@param args Args
---@param extra_lux_args string
local function add_project_dependencies(args, extra_lux_args)
  for _, dependency in ipairs(Project.runtime_dependencies(args.dependencies)) do
    OS.execute(Lux.add(dependency, extra_lux_args), error, args.is_debug)
  end
  for _, dependency in ipairs(args.test_dependencies) do
    OS.execute(Lux.add_test(dependency, extra_lux_args), error, args.is_debug)
  end
end

---@param directory string
---@param args Args
local function write_custom_template(directory, args)
  if not args.template then
    return
  end
  local content = assert(OS.read_file(args.template), 'Could not read ' .. args.template)
  print('Using custom extra.rockspec template: ' .. args.template)
  OS.write_file(directory .. '/extra.rockspec', content)
end

---@param args Args
---@param extra_lux_args string
---@return string stdout
local function run_generate_rockspec(args, extra_lux_args)
  return (OS.execute(Lux.generate_rockspec(extra_lux_args), error, args.is_debug))
end

---@param stdout string
---@return string rockspec_path
local function parse_rockspec_path(stdout)
  return assert(json.decode(stdout)[1], 'Could not determine the generated rockspec path.')
end

---@param package_name string
---@param rockspec_path string
---@param args Args
---@param extra_lux_args string
local function test_install_rockspec(package_name, rockspec_path, args, extra_lux_args)
  local tmp_dir = mk_tmp_tree(args)
  local install_cmd = Lux.install_rockspec(tmp_dir, rockspec_path, extra_lux_args)
  print('TEST: ' .. install_cmd)
  print(OS.execute(install_cmd, error, args.is_debug))
  local remove_cmd = Lux.uninstall(tmp_dir, package_name, extra_lux_args)
  print('TEST: ' .. remove_cmd)
  print(OS.execute(remove_cmd, error, args.is_debug))
end

---@param args Args
---@return fun(message: string) on_error
local function on_upload_error(args)
  return function(message)
    if message:find('already exists') and not args.fail_on_duplicate then
      print('The rock already exists on the remote. Doing nothing (`fail_on_duplicate` is false).')
    else
      error(message)
    end
  end
end

---@param args Args
---@param extra_lux_args string
local function upload(args, extra_lux_args)
  local cmd = Lux.api_key_env() .. Lux.upload(Lux.sign_protocol_from_env(), extra_lux_args)
  print('UPLOAD: ' .. cmd)
  print(OS.execute(cmd, on_upload_error(args), args.is_debug))
end

---@param package_name string
---@param version string|nil
---@return string
local function package_requirement(package_name, version)
  if version and version:match('^%d') then
    return package_name .. '@' .. version
  end
  return package_name
end

---@param package_name string
---@param version string|nil
---@param args Args
---@param extra_lux_args string
local function test_install_package(package_name, version, args, extra_lux_args)
  local tmp_dir = mk_tmp_tree(args)
  local cmd = Lux.install(tmp_dir, package_requirement(package_name, version), extra_lux_args)
  print('TEST: ' .. cmd)
  print(OS.execute(cmd, print, args.is_debug))
end

---@param package_version string|nil
---@return string|nil version
local function version_override(package_version)
  if not package_version or package_version == '' then
    return nil
  end
  local modrev = package_version:gsub('^v', '')
  if modrev == 'scm' or modrev == 'dev' or modrev:match('^%d') then
    return modrev
  end
  return nil
end

---@param args Args
---@return ResolvedRelease release
local function resolve_meta(args)
  local github_event_data = args.github_event_path and OS.read_file(args.github_event_path)
  local github_event = github_event_data and json.decode(github_event_data)
  ---@cast github_event GithubEvent|nil
  return Release.resolve {
    git_server_url = args.git_server_url,
    github_repo = args.github_repo,
    license = args.license,
    summary = args.summary,
    labels = args.labels,
    github_event = github_event,
  }
end

---@param release ResolvedRelease
---@param args Args
---@param version string|nil
---@return ProjectMeta
local function project_meta(release, args, version)
  return {
    version = version,
    lua_version = Project.lua_version(args.dependencies),
    summary = release.summary,
    detailed_description_lines = args.detailed_description_lines,
    labels = release.labels,
    license = release.license,
    homepage = release.homepage,
    repo_url = release.repo_url,
    copy_directories = args.copy_directories,
  }
end

---@param package_name string The name of the LuaRocks package.
---@param package_version string|nil The version of the LuaRocks package.
---@param args Args
local function luarocks_tag_release(package_name, package_version, args)
  package_name = package_name:lower()
  local version = version_override(package_version)
  local extra_lux_args =
    Lux.with_verbose(Lux.combine_args(args.extra_luarocks_args, args.extra_lux_args), args.is_debug)
  local release = resolve_meta(args)

  print('Generating Lux release for: ' .. package_name .. ' from ref ' .. args.git_ref .. '.')

  local project = Project.for_release(package_name, project_meta(release, args, version), '.')
  if project.generated then
    write_generated_project(project)
    add_project_dependencies(args, extra_lux_args)
  end

  write_custom_template(project.directory, args)

  local rockspec_path = parse_rockspec_path(run_generate_rockspec(args, extra_lux_args))
  test_install_rockspec(package_name, rockspec_path, args, extra_lux_args)

  if args.upload then
    upload(args, extra_lux_args)
    test_install_package(package_name, version, args, extra_lux_args)
  else
    print('Lux upload disabled. Skipping...')
  end

  print('')
  print('Done.')
end

return luarocks_tag_release
