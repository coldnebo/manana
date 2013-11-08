source 'https://rubygems.org'

# Specify your gem's dependencies in manana.gemspec
gemspec

# these aren't strictly needed for development but are nice to have
unless ENV["TRAVIS"] == "1"
  gem 'yard'
  gem 'redcarpet'
  gem 'simplecov'
  gem 'pry'
end

# for travis.cl
group :test do
  gem 'rake'
  gem 'mocha'
end