require 'minitest_helper'
require 'klass'

class TestManana < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Manana::VERSION
  end

  # initialize a very generic example object that does some stuff in initialization 
  # and has some instance methods you can call.
  def setup
  end

  # sanity check
  def test_that_things_work_without_manana
    obj = nil

    out, err = capture_io do
      obj = Klass.new
    end
    assert_match(/#{Klass::INITIALIZE_MESSAGE}/, out)
    assert_instance_of(String, obj.do_something)
    assert_match(/#{Klass::DO_SOMETHING_MESSAGE}/, obj.do_something)
    assert_raises RuntimeError do 
      obj.raise_something
    end

    begin
      obj.raise_something
    rescue Exception => e
      # make sure we get an appropriate stack trace at the point of raise.
      assert_match(/.*klass.rb:\d+:in .raise_something./, e.backtrace.first)
    end
  end

  def test_deferred_init
    obj = nil
    out, err = capture_io do
      obj = Manana.deferred_init {
        Klass.new
      }
    end
    # make sure the init isn't executed until we call...
    refute_match(/#{Klass::INITIALIZE_MESSAGE}/, out)

    # now call a method on the object...
    result = nil
    out, err = capture_io do
      result = obj.do_something
    end
    # and make sure the init was called
    assert_match(/#{Klass::INITIALIZE_MESSAGE}/, out)
    # and that we got the desired result
    assert_instance_of(String, result)
    assert_match(/#{Klass::DO_SOMETHING_MESSAGE}/, result)
    assert_raises RuntimeError do 
      obj.raise_something
    end

    begin
      obj.raise_something
    rescue Exception => e
      # make sure we get an appropriate stack trace at the point of raise.
      assert_match(/.*klass.rb:\d+:in .raise_something./, e.backtrace.first)
    end
  end

end
