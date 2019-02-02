require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :c do
  puts `rubocop ./lib/**/*.rb`
end

task :y do
  puts `yard doc ./lib/**/*.rb`
end

task :all do
  Rake::Task["build"].invoke
  Rake::Task["y"].invoke
  Rake::Task["c"].invoke
end