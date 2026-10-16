local Release = require('ltr.release')

local Rockspec = {}

---@param t string[]
---@return boolean
local function list_has_lua(t)
  for _, v in pairs(t) do
    if v == 'lua' or (type(v) == 'string' and string.match(v, '^lua%s+')) then
      return true
    end
  end
  return false
end

---@class (exact) GenerateMeta
---@field ref_type github_ref_type
---@field git_server_url string The github server's URL.
---@field github_repo string The github repository (owner/repo_name).
---@field license string|nil License SPDX ID (optional).
---@field git_ref string E.g. a tag or a commit sha.
---@field summary string Package summary.
---@field detailed_description_lines string[] Detailed description (list of lines).
---@field dependencies string[] List of LuaRocks package dependencies.
---@field test_dependencies string[] List of test suite dependencies.
---@field labels string[] List of labels to add to the rockspec.
---@field copy_directories string[] List of directories to add to the rockspec's copy_directories.
---@field repo_name string The repository name.
---@field github_event GithubEvent|nil GitHub event metadata, read from GITHUB_EVENT_PATH and decoded from JSON

---Generate a rockspec from a template
---@param package_name string The name of the LuaRocks package.
---@param modrev string the version of the package - in format 3.0 must follow the format '[%w.]+-[%d]+'
---@param specrev string the version of the rockspec
---@param rockspec_template string The template rockspec
---@param meta GenerateMeta
---@return string
function Rockspec.generate(package_name, modrev, specrev, rockspec_template, meta)
  local archive_dir_suffix = meta.ref_type == 'tag' and modrev or meta.git_ref

  ---@param xs string[]?
  ---@return string lua_list_string
  local function mk_lua_list_string(xs)
    if not xs or #xs == 0 then
      return '{ }'
    end
    return "{ '" .. table.concat(xs, "', '") .. "' } "
  end

  ---@param xs string[]?
  ---@return string lua_multiline_string
  local function mk_lua_multiline_str(xs)
    if not xs or #xs == 0 then
      return "''"
    end
    return '[[\n' .. table.concat(xs, '\n') .. ']]'
  end

  local release = Release.resolve(meta)
  local repo_url = release.repo_url
  local license = release.license and ("license = '" .. release.license .. "'") or ''

  ---@param str string
  ---@return string
  local function escape_quotes(str)
    local escaped = str:gsub("'", "\\'")
    return escaped
  end

  if not list_has_lua(meta.dependencies) then
    table.insert(meta.dependencies, 1, 'lua >= 5.1')
  end

  local is_release = modrev ~= 'scm' and modrev ~= 'dev'

  local rockspec = rockspec_template
    :gsub('$is_release', tostring(is_release))
    :gsub('$git_ref', meta.git_ref)
    :gsub('$modrev', modrev)
    :gsub('$specrev', specrev)
    :gsub('$repo_url', repo_url)
    :gsub('$archive_dir_suffix', archive_dir_suffix)
    :gsub('$package', package_name)
    :gsub('$summary', escape_quotes(release.summary))
    :gsub('$detailed_description', mk_lua_multiline_str(meta.detailed_description_lines))
    :gsub('$dependencies', mk_lua_list_string(meta.dependencies))
    :gsub('$test_dependencies', mk_lua_list_string(meta.test_dependencies))
    :gsub('$labels', mk_lua_list_string(release.labels))
    :gsub('$homepage', release.homepage)
    :gsub('$license', license)
    :gsub('$copy_directories', mk_lua_list_string(meta.copy_directories))
    :gsub('$repo_name', meta.repo_name)

  return rockspec
end

return Rockspec
