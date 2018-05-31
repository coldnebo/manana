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

