source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in manana.gemspec
gemspec

unless ENV["TRAVIS"] == "1"
  group :development, :test do 
    gem 'pry'
  end

  group :test do 
    gem 'simplecov', "~> 0.16.1"
  end
end

# these aren't strictly needed for development but are nice to have
# unless ENV["TRAVIS"] == "1"
  
#   group :development do
#     gem 'yard'
#     gem 'redcarpet'

#     if RUBY_VERSION =~ /^2\./
#       gem 'pry-byebug'
#     else
#       gem 'pry'
#     end

#   end

#   group :samples do
#     gem 'savon', '~> 2.3'
#     gem 'webmock'
#   end

#   group :test do 
#     gem 'simplecov'
#   end

# end

# # for travis.cl
# group :test do
#   gem 'mocha'
# end