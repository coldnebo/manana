unless ENV["TRAVIS"] == "1"
  require 'simplecov'
  require 'pry'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'manana'

require 'minitest/autorun'
require 'mocha/setup'

