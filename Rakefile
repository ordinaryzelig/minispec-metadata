require "bundler/gem_tasks"
require 'rake/testtask'

task :default => [:test, :test_tags]

Rake::TestTask.new :test do |t|
  t.pattern = 'spec/**/*.spec.rb'
end

task :test_tags => ['test_tags:inclusive', 'test_tags:exclusive', 'test_tags:matching_value', 'test_tags:mix']

namespace :test_tags do

  task :inclusive => :setup do |t|
    run_test_tag '--tag minitest_5', t
  end

  task :exclusive => :setup do |t|
    run_test_tag '--tag ~minitest_4', t
  end

  task :matching_value => :setup do |t|
    run_test_tag '--tag ~specific:value', t
  end

  task :mix => :setup do |t|
    run_test_tag '--tag minitest_5 --tag minitest_4 --tag specific:value --tag ~slow', t
  end

  task :setup do |t|
    require 'minispec-metadata'
    require 'minispec-metadata/tags'
    require 'ap'
  end

  def run_test_tag(tags, task)
    if MinispecMetadata.supports_tags?
      ap task.name
      sh "TEST_TAGS=true ruby spec/tags.spec.rb #{tags} -v"
      puts
    else
      warn 'Tags not supported on your setup. Please see minispec-metadata/tags for requirements'
    end
  end

end
