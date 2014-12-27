# For a bit of backward compatibility.
# Thanks to @jhsu for discovering the discrepancy.
if MiniTest::Unit.const_defined?(:TestCase)
  class MiniTest::Unit::TestCase
    def name
      __name__
    end
  end
end

# Y U NO Ruby 2.0????
unless Kernel.public_method_defined? :__dir__
  module Kernel
    def __dir__
      File.dirname(File.expand_path(__FILE__))
    end
  end
end
