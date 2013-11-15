require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task :default => :test

desc "install gems for running samples"
task :samples do
  Bundler.with_clean_env do
    sh "bundle install --gemfile=samples/common/samples.gemfile"
  end
end
