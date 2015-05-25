require "bundler/gem_tasks"
require 'rake/testtask'

# load all test files
test_tasks = Dir['test/*/'].map { |d| File.basename(d) }

# Setup test tasks for each type
test_tasks.each do |folder|
  Rake::TestTask.new("test:#{folder}") do |test|
    test.pattern = "test/#{folder}/**/*_test.rb"
    test.verbose = true
  end
end

# Setup task for complete test suit
desc "Run application test suite"
Rake::TestTask.new("test") do |test|
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
end
