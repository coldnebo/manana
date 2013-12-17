require "manana/version"


# *Manana* lets you defer the initialization of an object until its methods are called.
# @example basic usage - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
#   #   initialization...
#   client = Manana.deferred_init {
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

  # wraps an initialization block so that it can be deferred to a later time when object methods are called.
  # @example wrap an object - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
  #   client = Manana.deferred_init {
  #     Weather.setup  # initialize the class 
  #     Weather        # return the Weather class
  #   }
  # 
  # @param initialization_block [Proc] object initialization. the block must return the object to be wrapped.
  # @return [Manana] a wrapped version of the object.
  def self.deferred_init(&initialization_block)
    Manana.new(&initialization_block)
  end 

  # passes any method call through to the wrapped object after ensuring that the initialization block has 
  # successfully completed once (setting a valid instance of the object).  
  # @note Once the initialization block succeeds, it keeps the resulting object instance for subsequent method calls. 
  #
  # @example calling a wrapped object - see {https://github.com/coldnebo/manana/blob/master/samples/self_healing.rb samples/self_healing.rb}
  #   weather = client.city_weather("02201")
  #
  def method_missing(method, *args, &block)
    instance = get_instance
    instance.send(method, *args, &block);
  end

  private

  def initialize(&initialization_block)
    @deferred_initialization = initialization_block
  end

  def get_instance
    if @instance.nil?
      @instance = @deferred_initialization.call
    end
    @instance
  end


end
