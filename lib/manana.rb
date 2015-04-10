require "manana/version"


# *Manana* lets you defer the initialization of an object until its methods are called.
# @example basic usage - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
#   #   initialization...
#   client = Manana.wrap {
#     Weather.setup
#     Weather
#   }
#  
#   runtime_loop {
#     #   wait for next interval
#     weather = client.city_weather("02201")  # deferred initialization happens here once
#     puts "At %s the temperature is currently %s F and the humidity is %s." % [weather.city, weather.temperature, weather.relative_humidity]
#   }
#
class Manana
  private_class_method :new

  # wraps the initialization of an object so that it can be deferred to a later time when object methods are called.
  # @example wrap an object - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
  #   client = Manana.wrap {
  #     Weather.setup  # initialize the class 
  #     Weather        # return the Weather class
  #   }
  # 
  # @param initialization_block [Proc] object initialization. the block must return the object to be wrapped.
  # @return [Deferrable] a wrapped version of the object.
  def self.wrap(&initialization_block)
    Deferrable.send(:new,&initialization_block)
  end 

  # class that proxies all requests to the wrapped object, ensuring that the object has been correctly initialized first.
  class Deferrable < ::BasicObject
    private_class_method :new 

    # passes any method call through to the wrapped object after ensuring that the initialization block has 
    # successfully completed once (thereby initializing the wrapped object).  
    # @note Once the initialization block succeeds, it keeps the resulting object for subsequent method calls. 
    #
    # @example calling a wrapped object - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
    #   weather = client.city_weather("02201")
    #
    def method_missing(method, *args, &block)
      _object.send(method, *args, &block);
    end

    # allows direct access to the wrapped object -- useful for debugging
    # @return [Object] the object being wrapped
    def _object
      @mutex.synchronize do 
        if @object.nil?
          @object = @deferred_initialization.call
        end
        @object
      end
    end

  private
    def initialize(&initialization_block)
      @mutex = ::Mutex.new
      @deferred_initialization = initialization_block
    end
  end

end
