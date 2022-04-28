# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :run do
  ruby 'lib/cool_program.rb'
end

task :test do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
end
