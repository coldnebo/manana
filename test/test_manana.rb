require 'minitest_helper'

class TestManana < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Manana::VERSION
  end

  # initialize a very generic example object that does some stuff in initialization and has some instance methods you can call.
  def setup
    @klass = Class.new
    @klass.class_eval {
      def initialize
        puts "class initialized!"
      end

      def do_something
        "I did something!"      # simulate an arbitrary method
      end

      def add_something(x,y)
        x+y                     # simulate a method with params
      end

      def raise_something
        raise "kablewey!"       # simulate a call that raises an exception
      end

      def self.do_another_thing
        "I did something else"  # simulate a class method call
      end
    }
  end

  # sanity check
  def test_that_things_work_without_manana
    obj = nil
    out, err = capture_io do
      obj = @klass.new
    end
    assert_match(%r%class initialized!%, out)
    assert_instance_of(String, obj.do_something)
    assert_equal(5, obj.add_something(2,3))
    assert_raises RuntimeError do 
      obj.raise_something
    end
  end

  def test_deferred_init
    handle = nil
    out, err = capture_io do
      # the idea here is that we use the 'Strategy' pattern to store the method of initialization.
      # in this case, it's really simple, but in a network service, it might be a config + some class method calls 
      # to fully setup a service instance.
      handle = Manana.wrap {
        obj = @klass.new
      }
    end
    # make sure the init isn't executed until we call...
    refute_match(%r%class initialized!%, out)
    
    result = nil
    out, err = capture_io do
      result = handle.do_something
    end
    # now it should have been inited
    assert_match(%r%class initialized!%, out)
    # and the method we called used
    assert_instance_of(String, result)


  end


end
