if MiniTest.const_defined?(:Unit)
  class MiniTest::Unit::TestCase
    def name
      __name__
    end
  end
end
