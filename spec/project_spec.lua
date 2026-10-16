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

  describe('for_release', function()
    local OS = require('ltr.os')
    local real_file_exists
    local real_read_file
    before_each(function()
      real_file_exists = OS.file_exists
      real_read_file = OS.read_file
    end)
    after_each(function()
      OS.file_exists = real_file_exists
      OS.read_file = real_read_file
    end)

    local meta = {
      lua_version = '>= 5.1',
      summary = 'A package',
      detailed_description_lines = {},
      labels = {},
      license = nil,
      homepage = nil,
      repo_url = 'https://github.com/owner/my-package',
      copy_directories = {},
    }

    it('Prefers the consumer lux.toml when present', function()
      OS.file_exists = function()
        return true
      end
      OS.read_file = function()
        return 'package = "consumer"\n'
      end
      assert.are.same({
        directory = '/repo',
        content = 'package = "consumer"\n',
        generated = false,
      }, Project.for_release('my-package', meta, '/repo'))
    end)

    it('Generates a lux.toml when no consumer lux.toml is present', function()
      OS.file_exists = function()
        return false
      end
      assert.are.same({
        directory = '/repo',
        content = Project.generate('my-package', meta),
        generated = true,
      }, Project.for_release('my-package', meta, '/repo'))
    end)
  end)
end)
