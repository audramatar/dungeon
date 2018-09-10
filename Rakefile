begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  desc 'Run the tests'
  task :default => :spec

  desc 'Run the suite of tests in a docker container.'
  task :runtests => [:build] do
    sh 'docker run -it amatar/dungeon rake'
  end
rescue LoadError
  puts 'You need to have the rspec gem installed to run the tests.'
end

desc 'Play the game in a docker container.'
task :play => [:build] do
  sh 'docker run -it amatar/dungeon rake playgame'
end

desc 'Run the file starting the game demo.'
task :playgame do
  sh 'ruby ./main.rb'
end

desc 'Build a docker image for the game.'
task :build do
  sh 'docker build -t amatar/dungeon .'
end
