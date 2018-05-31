[![Build Status](https://travis-ci.org/coldnebo/manana.svg?branch=master)](https://travis-ci.org/coldnebo/manana)

# Manana

*Manana* lets you defer the initialization of an object until its methods are called.

This can be useful in cases where initialization may take a long time or fail due to errors. For example, in rails, if 
the database specified in `database.yml` doesn't exist at start time, the rails application will fail initialization. Likewise 
if you tie configuration of SOAP services (e.g. using [Savon](http://savonrb.com/version2/)) to your application initialization, 
and the service wsdl isn't up, your application will fail to start.

Instead, it is an established best practice in service-oriented architectures to make your application or service *startup order independent*: 
i.e. your app starts fast and initializes other dependencies afterwards, providing fault detection and *self-healing* properties for the app.

*Manana* is a simple approach that allows you to keep your configuration and initialization code in the same place, while deferring it to method calls. 

### Pros

* Reduces the startup time for your app. (i.e. moves the startup cost from initialization to first use)

* Once initialization is succesful, it stores the object instance for reuse.

* Until the initialization is successful, it will retry every time a method is called.

* You can layer more complex retry semantics such as [exponential backoff](http://en.wikipedia.org/wiki/Exponential_backoff) using this wrapper.  See [samples/exponential_backoff.rb](https://github.com/coldnebo/manana/blob/master/samples/exponential_backoff.rb)

### Cons

* If your initialization takes a very long time, (i.e. a cache) you may want to pre-warm it instead of taking the hit on the first use of the object.

* Very simple approach.  You may want more complex retry semantics,  or pooling.

### Similar ideas:

* [Connection pool](http://en.wikipedia.org/wiki/Connection_pool) of one?

* [Avoid Start Order Dependencies](http://wiki.osgi.org/wiki/Avoid_Start_Order_Dependencies)

* [Data Centers need shutdown/startup order](http://www.boche.net/blog/index.php/2009/01/01/datacenters-need-shutdownstartup-order/)

* 'self-healing' initialization faults from the practice of [Autonomic computing](http://en.wikipedia.org/wiki/Autonomic_computing)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'manana'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manana

## Usage

```ruby
require 'manana'

# initialization...
client = Manana.wrap {
  Weather.setup    # web service adapter setup
  Weather          # return the class instance
}

runtime_loop {
  #   wait for next interval
  weather = client.city_weather("02201")    # deferred initialization happens here once
  puts "At %s the temperature is currently %s F and the humidity is %s." % [weather.city, weather.temperature, weather.relative_humidity]
}
```


See the [samples](https://github.com/coldnebo/manana/blob/master/samples) for more detailed examples of use.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/manana. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Manana project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coldnebo/manana/blob/master/CODE_OF_CONDUCT.md).
