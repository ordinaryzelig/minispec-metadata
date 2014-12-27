require "bundler/gem_tasks"
require 'rake/testtask'

task :default => [:test, :test_tags]

Rake::TestTask.new :test do |t|
  t.pattern = 'spec/**/*.spec.rb'
end

task :test_tags do
  require 'minispec-metadata'
  if Minitest::Versions::MAJOR >= 5
    sh 'TEST_TAGS=true ruby spec/describe.spec.rb --tag minitest_5'
  end
end
