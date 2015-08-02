require_relative 'helper'

readme = File.readlines(File.dirname(__FILE__) + '/../README.md').map(&:chomp)
specs =
  readme.select do |line, idx|
    true if (line == '# readme.spec.rb')..(line == '```')
  end[0...-1]
  .join("\n")
instance_eval specs
