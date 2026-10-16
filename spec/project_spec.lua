describe('Project', function()
  local Project = require('ltr.project')

  it('Defaults the Lua version to >= 5.1', function()
    assert.are.same('>= 5.1', Project.lua_version { 'dkjson', 'luafilesystem' })
  end)

  it('Uses an explicit Lua version constraint', function()
    assert.are.same('>= 5.4', Project.lua_version { 'lua >= 5.4', 'dkjson' })
  end)

  it('Filters the Lua requirement from the runtime dependencies', function()
    assert.are.same(
      { 'dkjson', 'luafilesystem' },
      Project.runtime_dependencies {
        'lua >= 5.1',
        'dkjson',
        'luafilesystem',
      }
    )
  end)

  it('Generates a lux.toml from release metadata', function()
    local lux_toml = Project.generate('my-package', {
      lua_version = '>= 5.1',
      summary = 'A package',
      detailed_description_lines = { 'line one', 'line two' },
      labels = { 'neovim', 'lua' },
      license = 'MIT',
      homepage = 'https://example.com/my-package',
      repo_url = 'https://github.com/owner/my-package',
      copy_directories = { 'plugin', 'ftplugin' },
    })
    assert.are.same(
      [[
package = "my-package"
lua = ">= 5.1"

[description]
summary = "A package"
detailed = "line one\nline two"
license = "MIT"
homepage = "https://example.com/my-package"
labels = [ "neovim", "lua" ]

[source]
url = "https://github.com/owner/my-package/archive/$(REF).zip"
dev = "git+https://github.com/owner/my-package.git"

[build]
type = "builtin"
copy_directories = [ "plugin", "ftplugin" ]
]],
      lux_toml
    )
  end)

  it('Omits optional fields when absent', function()
    local lux_toml = Project.generate('my-package', {
      lua_version = '>= 5.1',
      summary = 'A package',
      detailed_description_lines = {},
      labels = {},
      license = nil,
      homepage = nil,
      repo_url = 'https://github.com/owner/my-package',
      copy_directories = {},
    })
    assert.are.same(
      [[
package = "my-package"
lua = ">= 5.1"

[description]
summary = "A package"

[source]
url = "https://github.com/owner/my-package/archive/$(REF).zip"
dev = "git+https://github.com/owner/my-package.git"

[build]
type = "builtin"
]],
      lux_toml
    )
  end)

  it('Escapes quotes and backslashes', function()
    local lux_toml = Project.generate('my-package', {
      lua_version = '>= 5.1',
      summary = 'A "quoted" summary',
      detailed_description_lines = {},
      labels = {},
      license = nil,
      homepage = nil,
      repo_url = 'https://github.com/owner/my-package',
      copy_directories = {},
    })
    assert.is_truthy(lux_toml:find('summary = "A \\"quoted\\" summary"', 1, true))
  end)
end)
