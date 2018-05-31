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
CLOBBER << ".yardoc"

#CLOBBER << Rake::FileList.new("coverage/**/*", "coverage")


desc "clean the intermediate yardoc and start a yard server - just for local development" 
task :yardserver do
  exec "yard server --reload -b 0.0.0.0"
end


require 'yard'
YARD::Rake::YardocTask.new :doc