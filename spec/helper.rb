require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/pride'
require 'minispec-metadata'

require 'awesome_print'

class MiniTest::Unit::TestCase
  parallelize_me!
end
