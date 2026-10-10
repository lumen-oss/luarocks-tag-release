describe('OS.execute', function()
  local OS = require('ltr.os')
  local real_execute
  before_each(function()
    real_execute = os.execute
  end)
  after_each(function()
    os.execute = real_execute
  end)
  it('Treats a boolean success (Lua 5.2+) as success', function()
    os.execute = function()
      return true, 'exit', 0
    end
    assert.is_true(pcall(OS.execute, 'true', error))
  end)
  it('Reports a boolean failure (Lua 5.2+)', function()
    os.execute = function()
      return nil, 'exit', 3
    end
    local ok, err = pcall(OS.execute, 'false', error)
    assert.is_false(ok)
    assert.is_truthy(err:find('exit code: 3', 1, true))
  end)
  it('Treats an integer success (Lua 5.1) as success', function()
    os.execute = function()
      return 0
    end
    assert.is_true(pcall(OS.execute, 'true', error))
  end)
  it('Reports an integer failure (Lua 5.1)', function()
    os.execute = function()
      return 256
    end
    local ok, err = pcall(OS.execute, 'false', error)
    assert.is_false(ok)
    assert.is_truthy(err:find('exit code: 256', 1, true))
  end)
end)
