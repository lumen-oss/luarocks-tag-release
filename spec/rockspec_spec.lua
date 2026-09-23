---@diagnostic disable: undefined-global
-- luacheck: globals package version description dependencies source build

local test_template = [[
local git_ref = '$git_ref'
local modrev = '$modrev'
local specrev = '$specrev'

local repo_url = '$repo_url'

rockspec_format = '3.0'
package = '$package'
version = modrev ..'-'.. specrev

description = {
  summary = '$summary',
  detailed = $detailed_description,
  labels = $labels,
  homepage = '$homepage',
  $license
}

dependencies = $dependencies

test_dependencies = $test_dependencies

source = {
  url = repo_url .. '/archive/' .. git_ref .. '.zip',
  dir = '$repo_name-' .. '$archive_dir_suffix',
}

build = {
  type = 'builtin',
  copy_directories = $copy_directories,
}
]]

local scm_template = [[
local git_ref = '$git_ref'
local modrev = '$modrev'
local is_release = '$is_release' == 'true'

local repo_url = 'https://github.com/nvim-neorocks/luarocks-tag-release'

rockspec_format = '3.0'
package = 'test_package'

dependencies = {
  'lua >= 5.1',
}

build = {
  type = 'builtin',
  copy_directories = { 'plugin' },
}

if is_release then
  version = modrev .. '-' .. '$specrev'
  source = {
    url = repo_url .. '/archive/' .. git_ref .. '.zip',
    dir = '$repo_name-' .. git_ref,
  }
else
  version = 'scm-1'
  source = {
    url = repo_url:gsub('https', 'git'),
  }
end
]]

---@param rockspec_str string The rockspec content
local function load_rockspec(rockspec_str)
  local rockspec_module = assert(loadstring(rockspec_str), 'Could not load generated rockspec')
  rockspec_module()
end

describe('Rockspec', function()
  local Rockspec = require('ltr.rockspec')
  ---@type GenerateMeta
  local meta = {
    ref_type = 'tag',
    git_server_url = 'https://github.com',
    github_repo = 'nvim-neorocks/luarocks-tag-release',
    git_ref = '1.0.0',
    summary = 'test summary',
    detailed_description_lines = { 'a line', 'another line' },
    dependencies = {},
    test_dependencies = {},
    labels = { 'neovim' },
    copy_directories = { 'plugin' },
    repo_name = 'luarocks-tag-release',
  }
  it('Generate (without lua dependency or license)', function()
    load_rockspec(Rockspec.generate('test_package', '1.0.0', '1', test_template, meta))
    assert.same(package, 'test_package')
    assert.same(version, '1.0.0-1')
    assert.same(description, {
      summary = 'test summary',
      detailed = 'a line\nanother line',
      labels = { 'neovim' },
      homepage = 'https://github.com/nvim-neorocks/luarocks-tag-release',
    })
    assert.same(build.copy_directories, { 'plugin' })
    assert.same(source.url, 'https://github.com/nvim-neorocks/luarocks-tag-release/archive/1.0.0.zip')
    assert.same(source.dir, 'luarocks-tag-release-1.0.0')
    assert.same(dependencies, { 'lua >= 5.1' })
  end)
  it('Generate (with license)', function()
    meta.license = 'AGPL3'
    load_rockspec(Rockspec.generate('test_package', '1.0.0', '1', test_template, meta))
    assert.same(description.license, 'AGPL3')
  end)
  it('Generate (with lua dependency)', function()
    meta.dependencies = { 'lua >= 5.4' }
    load_rockspec(Rockspec.generate('test_package', '1.0.0', '1', test_template, meta))
    assert.same(dependencies, { 'lua >= 5.4' })
  end)
  it('Generates a release rockspec from an scm template', function()
    load_rockspec(Rockspec.generate('test_package', '1.0.0', '1', scm_template, meta))
    assert.same(version, '1.0.0-1')
    assert.same(source.url, 'https://github.com/nvim-neorocks/luarocks-tag-release/archive/1.0.0.zip')
    assert.same(source.dir, 'luarocks-tag-release-1.0.0')
  end)
  it('Loads the same scm template standalone as an scm rockspec', function()
    load_rockspec(scm_template)
    assert.same(version, 'scm-1')
    assert.same(source.url, 'git://github.com/nvim-neorocks/luarocks-tag-release')
  end)
  it('Generates an scm rockspec from an scm template when version is scm', function()
    load_rockspec(Rockspec.generate('test_package', 'scm', '1', scm_template, meta))
    assert.same(version, 'scm-1')
    assert.same(source.url, 'git://github.com/nvim-neorocks/luarocks-tag-release')
  end)
  it('Generates an scm rockspec from an scm template when version is dev', function()
    load_rockspec(Rockspec.generate('test_package', 'dev', '1', scm_template, meta))
    assert.same(version, 'scm-1')
    assert.same(source.url, 'git://github.com/nvim-neorocks/luarocks-tag-release')
  end)
end)
