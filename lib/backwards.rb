# For a bit of backward compatibility.
# Thanks to @jhsu for discovering the discrepancy.
if Minitest::Versions::MAJOR <= 4
  class MiniTest::Unit::TestCase
    def name
      __name__
    end
  end
end

# Y U NO Ruby 2.0????
unless Kernel.respond_to?(:__dir__, false)
  module Kernel
    def __dir__
      File.dirname(File.expand_path(__FILE__))
    end
  end
end
