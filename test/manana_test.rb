require "test_helper"

class MyObject
  def my_method; end
end


describe Manana do 

  let(:mock) { Minitest::Mock.new }

  it "must have a version number" do 
    refute_nil ::Manana::VERSION
  end

  it "should wrap an object initialization block" do
    mock.expect :my_method, true

    MyObject.stub :new, mock do 
      obj = Manana.wrap { 
        MyObject.new
      }
      obj.my_method 
    end
  end

  it "should not obscure the wrap method" do
    mock.expect :wrap, true
    
    MyObject.stub :new, mock do 
      obj = Manana.wrap { 
        MyObject.new
      }
      obj.wrap
    end  
  end

  it "should fail-fast" do
    MyObject.stub :new, -> { raise "boom" } do 
      obj = Manana.wrap { 
        MyObject.new
      }
      assert_raises(RuntimeError) { obj.my_method }
    end
  end

  it "should provide access to the underlying object" do 
    obj = Manana.wrap { 
      MyObject.new
    }
    assert obj._object.class == MyObject
  end

  it "should be threadsafe" do 
    # the init shouldn't be called more than once.
    mock.expect :once, true
    3.times { mock.expect :my_method, true }

    MyObject.stub :new, mock do 
      obj = Manana.wrap {
        sleep(0.25)
        mock.once
        MyObject.new
      }

      threads = (1..3).map{|i| Thread.new{ obj.my_method } }
      threads.map{|t| t.join }
    end
  end

end
