local Lux = {}

---@param extra_lux_args string|nil
---@return string
local function lux_args_prefix(extra_lux_args)
  if extra_lux_args and extra_lux_args ~= '' then
    return extra_lux_args .. ' '
  end
  return ''
end

---@param tree string
---@param extra_lux_args string|nil
---@param subcommand string
---@return string
local function with_tree(tree, extra_lux_args, subcommand)
  return 'lx ' .. lux_args_prefix(extra_lux_args) .. '--tree ' .. tree .. ' ' .. subcommand
end

---@param tree string
---@param rockspec_path string
---@param extra_lux_args string|nil
---@return string
function Lux.install_rockspec(tree, rockspec_path, extra_lux_args)
  return with_tree(tree, extra_lux_args, 'install-rockspec ' .. rockspec_path)
end

---@param tree string
---@param package string
---@param extra_lux_args string|nil
---@return string
function Lux.uninstall(tree, package, extra_lux_args)
  return with_tree(tree, extra_lux_args, 'uninstall ' .. package)
end

---@param tree string
---@param package_req string
---@param extra_lux_args string|nil
---@return string
function Lux.install(tree, package_req, extra_lux_args)
  return with_tree(tree, extra_lux_args, 'install "' .. package_req .. '"')
end

---@param dependency string
---@param extra_lux_args string|nil
---@return string
function Lux.add(dependency, extra_lux_args)
  return 'lx --no-luarc ' .. lux_args_prefix(extra_lux_args) .. 'add "' .. dependency .. '"'
end

---@param dependency string
---@param extra_lux_args string|nil
---@return string
function Lux.add_test(dependency, extra_lux_args)
  return 'lx --no-luarc ' .. lux_args_prefix(extra_lux_args) .. 'add --test "' .. dependency .. '"'
end

---@param extra_lux_args string|nil
---@param version string|nil
---@return string
function Lux.generate_rockspec(extra_lux_args, version)
  local version_arg = version and version ~= '' and (' --version=' .. version) or ''
  return 'lx --no-luarc ' .. lux_args_prefix(extra_lux_args) .. 'generate-rockspec --output-format json' .. version_arg
end

---@param sign_protocol string|nil
---@return string
local function resolve_sign_protocol(sign_protocol)
  if sign_protocol == nil then
    return Lux.sign_protocol_from_env()
  end
  return sign_protocol
end

---@param protocol string
---@return string
local function sign_protocol_flag(protocol)
  return protocol ~= '' and (' --sign-protocol ' .. protocol) or ''
end

---@param sign_protocol string|nil
---@param extra_lux_args string|nil
---@return string
function Lux.upload(sign_protocol, extra_lux_args)
  local protocol = resolve_sign_protocol(sign_protocol)
  return 'lx --no-luarc '
    .. lux_args_prefix(extra_lux_args)
    .. '--no-prompt true upload'
    .. sign_protocol_flag(protocol)
end

---@param extra_luarocks_args string[] Legacy `extra_luarocks_args` tokens.
---@return string[] lux_args
function Lux.map_extra_args(extra_luarocks_args)
  local lux_args = {}
  for _, arg in ipairs(extra_luarocks_args) do
    if arg:match('^[%u%d_]+=') then
      lux_args[#lux_args + 1] = '--variables'
      lux_args[#lux_args + 1] = arg
    else
      lux_args[#lux_args + 1] = arg
    end
  end
  return lux_args
end

---@param extra_luarocks_args string[]
---@param extra_lux_args string[]
---@return string
function Lux.combine_args(extra_luarocks_args, extra_lux_args)
  local combined = Lux.map_extra_args(extra_luarocks_args)
  for _, arg in ipairs(extra_lux_args) do
    combined[#combined + 1] = arg
  end
  return table.concat(combined, ' ')
end

---@param extra_lux_args string
---@param verbose boolean
---@return string
function Lux.with_verbose(extra_lux_args, verbose)
  if not verbose then
    return extra_lux_args
  end
  return extra_lux_args == '' and '--verbose' or (extra_lux_args .. ' --verbose')
end

---@param lua_version string|nil
---@param extra_lux_args string
---@return string
function Lux.with_lua_version(lua_version, extra_lux_args)
  if not lua_version or lua_version == '' or extra_lux_args:match('%-%-lua%-version') then
    return extra_lux_args
  end
  if extra_lux_args == '' then
    return '--lua-version ' .. lua_version
  end
  return '--lua-version ' .. lua_version .. ' ' .. extra_lux_args
end

---@return string
function Lux.sign_protocol_from_env()
  return os.getenv('LTR_SIGN_PROTOCOL') or 'none'
end

---Shell prefix that exposes the API key to lux via `LUX_API_KEY`,
---falling back to the deprecated `LUAROCKS_API_KEY`.
---@return string
function Lux.api_key_env()
  if os.getenv('LUX_API_KEY') or not os.getenv('LUAROCKS_API_KEY') then
    return ''
  end
  return 'env LUX_API_KEY="$LUAROCKS_API_KEY" '
end

return Lux
