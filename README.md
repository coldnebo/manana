# Manana

*Manana* lets you defer the initialization of any class to when an instance method is called.

This can be useful in cases where class initialization may take a long time or fail due to errors (i.e. a network service). 
In these situations, you don't want to tie the initialization of service adapters to the initialization of your application, 
because if the service init fails, then your app fails to init and start (i.e. you want your app to be self-healing and 
retry initialization when the method is called later)... also it can unncessarily increase the startup
time of your app for testcases, etc.

## Installation

Add this line to your application's Gemfile:

    gem 'manana'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manana

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
