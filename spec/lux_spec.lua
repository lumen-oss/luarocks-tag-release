describe('Lux', function()
  local Lux = require('ltr.lux')

  it('Generates an install-rockspec command', function()
    assert.are.same(
      'lx --tree /tmp/tree install-rockspec foo-1.0-1.rockspec',
      Lux.install_rockspec('/tmp/tree', 'foo-1.0-1.rockspec')
    )
  end)

  it('Generates an uninstall command', function()
    assert.are.same('lx --tree /tmp/tree uninstall foo', Lux.uninstall('/tmp/tree', 'foo'))
  end)

  it('Generates an install command with a package requirement', function()
    assert.are.same('lx --tree /tmp/tree install "foo@1.0.0"', Lux.install('/tmp/tree', 'foo@1.0.0'))
  end)

  it('Generates an upload command with an explicit sign protocol', function()
    assert.are.same('lx --no-luarc --no-prompt true upload --sign-protocol none', Lux.upload('none'))
  end)

  describe('sign protocol from the environment', function()
    local real_getenv
    before_each(function()
      real_getenv = os.getenv
    end)
    after_each(function()
      os.getenv = real_getenv
    end)

    it('Defaults to none when LTR_SIGN_PROTOCOL is unset', function()
      os.getenv = function()
        return nil
      end
      assert.are.same('none', Lux.sign_protocol_from_env())
      assert.are.same('lx --no-luarc --no-prompt true upload --sign-protocol none', Lux.upload())
    end)

    it('Reads LTR_SIGN_PROTOCOL', function()
      os.getenv = function(name)
        return name == 'LTR_SIGN_PROTOCOL' and 'openpgp' or nil
      end
      assert.are.same('openpgp', Lux.sign_protocol_from_env())
      assert.are.same('lx --no-luarc --no-prompt true upload --sign-protocol openpgp', Lux.upload())
    end)
  end)

  it('Generates an add command', function()
    assert.are.same('lx --no-luarc add "foo"', Lux.add('foo'))
  end)

  it('Generates a test add command', function()
    assert.are.same('lx --no-luarc add --test "busted"', Lux.add_test('busted'))
  end)

  it('Generates a generate-rockspec command', function()
    assert.are.same('lx --no-luarc generate-rockspec --output-format json', Lux.generate_rockspec())
  end)

  it('Passes an optional version to generate-rockspec', function()
    assert.are.same(
      'lx --no-luarc --lua-version 5.1 generate-rockspec --output-format json --version=1.2.3',
      Lux.generate_rockspec('--lua-version 5.1', '1.2.3')
    )
  end)

  it('Omits an empty generate-rockspec version', function()
    assert.are.same('lx --no-luarc generate-rockspec --output-format json', Lux.generate_rockspec(nil, ''))
  end)

  it('Injects options into tree commands', function()
    assert.are.same(
      'lx --lua-version 5.4 --tree /tmp/tree install-rockspec foo.rockspec',
      Lux.install_rockspec('/tmp/tree', 'foo.rockspec', '--lua-version 5.4')
    )
  end)

  it('Injects options into add commands', function()
    assert.are.same('lx --no-luarc --preset nvim add "foo"', Lux.add('foo', '--preset nvim'))
  end)

  it('Maps legacy KEY=VALUE args to --variables', function()
    assert.are.same(
      { '--variables', 'CURL_INCDIR=/usr/include', '--lua-version', '5.4' },
      Lux.map_extra_args { 'CURL_INCDIR=/usr/include', '--lua-version', '5.4' }
    )
  end)

  it('Combines legacy and lux args', function()
    assert.are.same(
      '--variables CURL_INCDIR=/x --preset nvim',
      Lux.combine_args({ 'CURL_INCDIR=/x' }, { '--preset', 'nvim' })
    )
  end)

  it('Appends the verbose flag when debugging', function()
    assert.are.same('--verbose', Lux.with_verbose('', true))
    assert.are.same('--preset nvim --verbose', Lux.with_verbose('--preset nvim', true))
    assert.are.same('--preset nvim', Lux.with_verbose('--preset nvim', false))
  end)

  it('Adds the default Lua version', function()
    assert.are.same('--lua-version 5.1', Lux.with_lua_version('5.1', ''))
  end)

  it('Appends the default Lua version to extra args', function()
    assert.are.same('--lua-version 5.1 --preset nvim', Lux.with_lua_version('5.1', '--preset nvim'))
  end)

  it('Does not override an explicit Lua version', function()
    assert.are.same('--lua-version 5.4', Lux.with_lua_version('5.1', '--lua-version 5.4'))
  end)

  it('Does not add a Lua version when unset', function()
    assert.are.same('--preset nvim', Lux.with_lua_version('', '--preset nvim'))
  end)

  describe('api key environment', function()
    local real_getenv
    before_each(function()
      real_getenv = os.getenv
    end)
    after_each(function()
      os.getenv = real_getenv
    end)

    it('Adds no prefix when LUX_API_KEY is set', function()
      os.getenv = function(name)
        return name == 'LUX_API_KEY' and 'lux-key' or nil
      end
      assert.are.same('', Lux.api_key_env())
    end)

    it('Maps the deprecated LUAROCKS_API_KEY', function()
      os.getenv = function(name)
        return name == 'LUAROCKS_API_KEY' and 'legacy-key' or nil
      end
      assert.are.same('env LUX_API_KEY="$LUAROCKS_API_KEY" ', Lux.api_key_env())
    end)

    it('Adds no prefix when no key is set', function()
      os.getenv = function()
        return nil
      end
      assert.are.same('', Lux.api_key_env())
    end)
  end)
end)
