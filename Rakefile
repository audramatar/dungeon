require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Run the tests'
task :default => :spec

desc 'Run the suite of tests in a docker container.'
task :runtests => [:build] do
  sh 'docker run -it amatar/dungeon rake'
end

desc 'Build a docker image for the game.'
task :build do
  sh 'docker build -t amatar/dungeon .'
end
