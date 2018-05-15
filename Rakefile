require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc "install gems for running samples"
task :samples do
  Bundler.with_clean_env do
    sh "bundle install --gemfile=samples/common/samples.gemfile"
  end
end


# require 'pry'
# binding.pry

CLOBBER << "coverage"
CLOBBER << "samples/common/samples.gemfile.lock"

#CLOBBER << Rake::FileList.new("coverage/**/*", "coverage")

