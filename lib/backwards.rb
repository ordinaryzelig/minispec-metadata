# For a bit of backward compatibility.
# Thanks to @jhsu for discovering the discrepancy.
if Minitest::Versions::MAJOR <= 4
  class MiniTest::Unit::TestCase
    def name
      __name__
    end
  end
end
