require_relative 'helper'

readme = File.readlines(File.dirname(__FILE__) + '/../README.md').map(&:chomp)
tests =
  readme.select do |line, idx|
    true if (line == '# readme.test.spec.rb')..(line == '```')
  end[0...-1]
  .join("\n")
instance_eval tests
