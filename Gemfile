source 'https://rubygems.org'

# Specify your gem's dependencies in manana.gemspec
gemspec

# these aren't strictly needed for development but are nice to have
unless ENV["TRAVIS"] == "1"
  
  group :development do
    gem 'yard'
    gem 'redcarpet'

    gem 'pry'
    gem 'pry-debugger'
    gem 'pry-rescue'
    gem 'pry-stack_explorer'
  end

  group :samples do
    gem 'savon', '~> 2.3'
    gem 'webmock'
  end

  group :test do 
    gem 'simplecov'
  end

end

# for travis.cl
group :test do
  gem 'mocha'
end