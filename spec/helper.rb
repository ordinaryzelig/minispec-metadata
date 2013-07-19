require 'bundler/setup'
require 'awesome_print'

require 'minitest/autorun'
require 'minitest/pride'
require 'minispec-metadata'

class MiniTest::Unit::TestCase
  parallelize_me!
end
