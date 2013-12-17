unless ENV["TRAVIS"] == "1"
  require 'simplecov'
  require 'pry'
  SimpleCov.start do
    add_filter "/test/"
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'manana'

require 'minitest/autorun'
require 'mocha/setup'

