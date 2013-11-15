# This sample demonstrates how Manana may be used to create a self-healing soap adapter
# by wrapping an existing Savon::Model client.
#
# run from the gem dir with: 
# $ rake samples
# $ ruby samples/self_healing.rb 

require_relative 'common/samples_helper.rb'

# ------------------------- sample code starts here -------------------------

require 'manana'
require 'savon'
require 'ostruct'

# used to simulate conn up/down
require 'webmock'
include WebMock::API
# fake a failure to get the wsdl (service down temporarily)
stub_request(:any, /wsf.cdyne.com\/.*/).
  to_return(:status => 500, :body => "Internal Server Error", :headers => {})


LOGGING_ENABLED = false
HTTPI.log = false unless LOGGING_ENABLED

class Weather < OpenStruct
  extend Savon::Model

  client wsdl: "http://wsf.cdyne.com/WeatherWS/Weather.asmx?WSDL", convert_request_keys_to: :none, log: LOGGING_ENABLED

  def self.setup
    # if this were outside of setup() the class would fail to load if the service was down. 
    # instead we dynamically initialize the available operations from withing a class method to be used by the Manana wrapper. 
    operations *client.operations
  end 
  
  def self.city_weather(zip)
    resp = get_city_weather_by_zip(message: {"ZIP" => zip})
    weather = resp.body[:get_city_weather_by_zip_response][:get_city_weather_by_zip_result]
    Weather.new(weather)
  end
end


# ------------ initialization code

# Before we start, we use Manana to wrap the client setup so that method calls on the client can be self-healing in case of failure.
# NOTE: that the caller doesn't have to deal with whether or not this initialization succeeded, they can just call the client methods repeatedly.
client = Manana.wrap {
  Weather.setup
  Weather
}


# ------------ runtime code

# first call fails...
#  a) Weather.setup() called, but raises because the server is 500.
begin
  weather = client.city_weather("02201")
rescue Wasabi::Resolver::HTTPError => e
  puts "# 1. first call failed as expected, because Weather.setup() couldn't connect to provide the operations for the client."
end

# server restored
WebMock.disable!

# second call ok...
#  a) Weather.setup() succeeds, caches instance for future use.
#  b) city_weather() succeeds.
weather = client.city_weather("02201")

puts "# 2. second call should succeed; Weather.setup() runs successfully and returns a successfully intialized Weather class."
puts "  > At %s the temperature is currently %s F and the humidity is %s." % [weather.city, weather.temperature, weather.relative_humidity]

# server down again
WebMock.enable!

# third call; service down again...
# remember, we already have a valid instance, so Weather.setup() is not called this time.
# a) city_weather() fails because the server is 500.
begin
  weather = client.city_weather("02201")
rescue Savon::HTTPError => e
  puts "# 3. third call fails; the connection is down again, but this time the failure is in the API call since Weather has successfully intialized opertaions from call #2."
end


# server restored
WebMock.disable!

# fourth call ok...
# a) city_weather() succeeds.
weather = client.city_weather("02201")

puts "# 4. fourth call should succeed; connection is up again, still using cached operations from the first time service was up (call #2)."
puts "  > At %s the temperature is currently %s F and the humidity is %s." % [weather.city, weather.temperature, weather.relative_humidity]


puts "\nThis concludes the demonstration of how Manana provides self-healing capability to a web-service adapter."



