local Project = {}

---@param str string
---@return string
local function escape(str)
  return (str:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t'))
end

---@param str string
---@return string
local function toml_string(str)
  return '"' .. escape(str) .. '"'
end

---@param xs string[]
---@return string
local function toml_array(xs)
  if #xs == 0 then
    return '[]'
  end
  local parts = {}
  for _, x in ipairs(xs) do
    parts[#parts + 1] = toml_string(x)
  end
  return '[ ' .. table.concat(parts, ', ') .. ' ]'
end

---@param dependency string
---@return boolean
local function is_lua(dependency)
  return dependency == 'lua' or dependency:match('^lua%s+') ~= nil
end

---@param dependencies string[]
---@return string lua_version The Lua version constraint for the top-level `lua` field.
function Project.lua_version(dependencies)
  for _, dependency in ipairs(dependencies) do
    if is_lua(dependency) then
      return dependency:match('^lua%s+(.+)$') or '>= 5.1'
    end
  end
  return '>= 5.1'
end

---@param dependencies string[]
---@return string[] runtime_dependencies Dependencies excluding any Lua requirement.
function Project.runtime_dependencies(dependencies)
  local runtime_dependencies = {}
  for _, dependency in ipairs(dependencies) do
    if not is_lua(dependency) then
      runtime_dependencies[#runtime_dependencies + 1] = dependency
    end
  end
  return runtime_dependencies
end

---@class (exact) ProjectMeta
---@field lua_version string The Lua version constraint.
---@field summary string Package summary.
---@field detailed_description_lines string[] Detailed description (list of lines).
---@field labels string[] List of labels.
---@field license string|nil License SPDX ID (optional).
---@field homepage string|nil Package homepage (optional).
---@field repo_url string The repository URL.
---@field copy_directories string[] Directories to copy to the rock's `etc` tree.

---Generate a `lux.toml` project from release metadata.
---Dependencies are added separately with `lx add`, so they are not part of the output.
---@param package_name string The name of the package.
---@param meta ProjectMeta
---@return string lux_toml
function Project.generate(package_name, meta)
  local lines = {
    'package = ' .. toml_string(package_name),
    'lua = ' .. toml_string(meta.lua_version),
    '',
    '[description]',
    'summary = ' .. toml_string(meta.summary),
  }
  if #meta.detailed_description_lines > 0 then
    lines[#lines + 1] = 'detailed = ' .. toml_string(table.concat(meta.detailed_description_lines, '\n'))
  end
  if meta.license then
    lines[#lines + 1] = 'license = ' .. toml_string(meta.license)
  end
  if meta.homepage and meta.homepage ~= '' then
    lines[#lines + 1] = 'homepage = ' .. toml_string(meta.homepage)
  end
  if #meta.labels > 0 then
    lines[#lines + 1] = 'labels = ' .. toml_array(meta.labels)
  end
  lines[#lines + 1] = ''
  lines[#lines + 1] = '[source]'
  lines[#lines + 1] = 'url = ' .. toml_string(meta.repo_url .. '/archive/$(REF).zip')
  lines[#lines + 1] = 'dev = ' .. toml_string('git+' .. meta.repo_url .. '.git')
  lines[#lines + 1] = ''
  lines[#lines + 1] = '[build]'
  lines[#lines + 1] = 'type = "builtin"'
  if #meta.copy_directories > 0 then
    lines[#lines + 1] = 'copy_directories = ' .. toml_array(meta.copy_directories)
  end
  return table.concat(lines, '\n') .. '\n'
end

return Project
