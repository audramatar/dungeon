require 'rake/testtask'

task default: :test

desc 'Run the tests'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb']
  t.warning = false
end

desc 'Run the suite of tests in a docker container.'
task :runtests => [:build] do
  sh 'docker run -it amatar/dungeon rake'
end

desc 'Build a docker image for the game.'
task :build do
  sh 'docker build -t amatar/dungeon .'
end
