unless ENV["TRAVIS"] == "1"
  require 'pry'
  require 'simplecov'
  SimpleCov.start do
    add_filter "/test/"
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "manana"

require "minitest/autorun"

