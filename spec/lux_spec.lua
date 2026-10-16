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
