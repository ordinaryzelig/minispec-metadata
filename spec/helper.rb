require 'bundler/setup'
require 'awesome_print'

require 'minitest/autorun'
require 'minitest/pride'
require 'minispec-metadata'

class Minitest::Test
  parallelize_me!
end
