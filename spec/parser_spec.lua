describe('Parser', function()
  local Parser = require('ltr.parser')
  it('Parse list args', function()
    local args = [[
      first
      second
      third
      fourth fith
    ]]
    local result = Parser.parse_list_args(args)
    assert.same(result, { 'first', 'second', 'third', 'fourth fith' })
  end)
  it('Parse copy_directory args', function()
    assert.same(
      { 'first', 'second', 'third' },
      Parser.parse_copy_directory_args([[
      first
      second
      third
    ]])
    )
  end)
  it('Parse copy_directory args with {{ neovim.plugin.dirs }}', function()
    local result = Parser.parse_copy_directory_args([[
      {{ neovim.plugin.dirs }}
      first
      second
      third
    ]])
    assert.same(result, {
      'after',
      'autoload',
      'colors',
      'compiler',
      'doc',
      'filetype.lua',
      'ftdetect',
      'ftplugin',
      'indent',
      'keymap',
      'lang',
      'lsp',
      'menu.vim',
      'parser',
      'parser-info',
      'plugin',
      'queries',
      'query',
      'rplugin',
      'spell',
      'syntax',
      'first',
      'second',
      'third',
    })
  end)
end)
