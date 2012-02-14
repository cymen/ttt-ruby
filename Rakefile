require 'rspec/core/rake_task'
require 'rake/testtask'

RSpec::Core::RakeTask.new(:spec)

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

task :default => [ :spec, :test ] 

