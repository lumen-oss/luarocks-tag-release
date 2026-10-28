local command = arg[1] or 'run'
local valid_commands = { generate = true, upload = true, test = true, run = true }
assert(valid_commands[command], 'Unknown command: ' .. command .. '. Expected generate, upload, test, or run.')

local Parser = require('ltr.parser')
local OS = require('ltr.os')

local function getenv_or_err(env_var)
  return assert(os.getenv(env_var), env_var .. ' not set.')
end

local function getenv_or_empty(env_var)
  return os.getenv(env_var) or ''
end

local valid_inputs = {
  name = true,
  version = true,
  dependencies = true,
  test_dependencies = true,
  labels = true,
  copy_directories = true,
  summary = true,
  detailed_description = true,
  template = true,
  license = true,
  extra_luarocks_args = true,
  extra_lux_args = true,
  lua_version = true,
  fail_on_duplicate = true,
}
local inputs = {}
for index = 2, #arg, 2 do
  local name = arg[index]:match('^%-%-([%w%-]+)$')
  name = name and name:gsub('-', '_')
  assert(valid_inputs[name], 'Unknown option: ' .. arg[index])
  inputs[name] = assert(arg[index + 1], 'Missing value for ' .. arg[index])
end

---Return the input value, or an empty string when omitted.
---@param name string
---@return string
local function getinput_or_empty(name)
  return inputs[name] or ''
end

local luarocks_tag_release = require('luarocks-tag-release')
local command_args = {
  extra_luarocks_args = Parser.parse_list_args(getinput_or_empty('extra_luarocks_args')),
  extra_lux_args = Parser.parse_list_args(getinput_or_empty('extra_lux_args')),
  lua_version = getinput_or_empty('lua_version'),
  is_debug = os.getenv('RUNNER_DEBUG') == '1',
  fail_on_duplicate = getinput_or_empty('fail_on_duplicate') == 'true',
}

if #command_args.extra_luarocks_args > 0 then
  print('::warning::extra_luarocks_args is deprecated; please use extra_lux_args instead.')
end

if command == 'upload' then
  luarocks_tag_release.upload(command_args)
  return
elseif command == 'test' then
  luarocks_tag_release.test(getinput_or_empty('name'), getinput_or_empty('version'), command_args)
  return
end

local github_repo = os.getenv('GITHUB_REPOSITORY_OVERRIDE') or getenv_or_err('GITHUB_REPOSITORY')

local repo_name = assert(
  string.match(github_repo, '/(.+)'),
  [[
    Could not determine repository name from GITHUB_REPOSITORY.
    If you see this, please report this as a bug.
  ]]
)

local git_server_url = os.getenv('GIT_SERVER_URL_OVERRIDE') or getenv_or_err('GITHUB_SERVER_URL')

local is_pull_request = getenv_or_empty('GITHUB_EVENT_NAME') == 'pull_request'

local license_input = getinput_or_empty('license')
local template_input = getinput_or_empty('template')
local package_name = getinput_or_empty('name')
---@type string | nil
local package_version = is_pull_request and '0.0.0' or getinput_or_empty('version')

---@type Args
local args = {
  github_repo = github_repo,
  repo_name = repo_name,
  git_server_url = git_server_url,
  dependencies = Parser.parse_list_args(getinput_or_empty('dependencies')),
  test_dependencies = Parser.parse_list_args(getinput_or_empty('test_dependencies')),
  labels = Parser.parse_list_args(getinput_or_empty('labels')),
  copy_directories = OS.filter_existing_directories(
    Parser.parse_copy_directory_args(getinput_or_empty('copy_directories'))
  ),
  summary = getinput_or_empty('summary'),
  detailed_description_lines = Parser.parse_list_args(getinput_or_empty('detailed_description')),
  upload = not is_pull_request,
  license = license_input ~= '' and license_input or nil,
  template = template_input ~= '' and template_input or nil,
  extra_luarocks_args = command_args.extra_luarocks_args,
  extra_lux_args = command_args.extra_lux_args,
  lua_version = command_args.lua_version,
  github_event_path = getenv_or_err('GITHUB_EVENT_PATH'),
  ref_type = os.getenv('GITHUB_REF_TYPE_OVERRIDE') or getenv_or_err('GITHUB_REF_TYPE'),
  is_debug = command_args.is_debug,
  fail_on_duplicate = command_args.fail_on_duplicate,
}

local function warn_deprecated_test_dependencies(parsed_args)
  if #parsed_args.test_dependencies > 0 then
    print('::warning::test_dependencies is deprecated and is no longer published to the rockspec.')
  end
end

warn_deprecated_test_dependencies(args)

print('Workflow has been triggered by: ' .. args.ref_type)
local is_tag = args.ref_type == 'tag'
if not is_tag then
  print('Publishing an untagged release.')
end

if is_pull_request then
  print('Running in a pull request.')
end

print('Running ' .. command .. ' for: ' .. package_name:lower() .. '.')

luarocks_tag_release[command](package_name, package_version, args)
