require 'minitest_helper'
require 'base_klass'

class TestWithSubclass < Minitest::Test
  
  # initialize a very generic example object that does some stuff in initialization and has some instance methods you can call.
  def setup
    BaseKlass.class_variable_set(:@@connected, false)
  end

  # sanity check
  def test_that_things_work_without_manana
    @subklass = Class.new(BaseKlass)

    assert_raises RuntimeError do
      res = @subklass.find
    end

    BaseKlass.establish_connection

    res = @subklass.find
    refute_empty(res)

  end

  def test_deferred_init

    @subklass = Manana.deferred_init {
      unless BaseKlass.connected?
        BaseKlass.establish_connection 
      end
      subklass = Class.new(BaseKlass)
    }

    res = @subklass.find
    refute_empty(res)
    assert(BaseKlass.connected?)

  end


end
