local Lux = {}

---@param tree string
---@param subcommand string
---@return string
local function with_tree(tree, subcommand)
  return 'lx --tree ' .. tree .. ' ' .. subcommand
end

---@param tree string
---@param rockspec_path string
---@return string
function Lux.install_rockspec(tree, rockspec_path)
  return with_tree(tree, 'install-rockspec ' .. rockspec_path)
end

---@param tree string
---@param package string
---@return string
function Lux.uninstall(tree, package)
  return with_tree(tree, 'uninstall ' .. package)
end

---@param tree string
---@param package_req string
---@return string
function Lux.install(tree, package_req)
  return with_tree(tree, 'install "' .. package_req .. '"')
end

---@param dependency string
---@return string
function Lux.add(dependency)
  return 'lx --no-luarc add "' .. dependency .. '"'
end

---@param dependency string
---@return string
function Lux.add_test(dependency)
  return 'lx --no-luarc add --test "' .. dependency .. '"'
end

---@return string
function Lux.generate_rockspec()
  return 'lx --no-luarc generate-rockspec --output-format json'
end

---@param sign_protocol string|nil
---@return string
function Lux.upload(sign_protocol)
  local protocol = sign_protocol or Lux.sign_protocol_from_env()
  return 'lx --no-luarc --no-prompt true upload --sign-protocol ' .. protocol
end

---@return string
function Lux.sign_protocol_from_env()
  return os.getenv('LTR_SIGN_PROTOCOL') or 'none'
end

return Lux
