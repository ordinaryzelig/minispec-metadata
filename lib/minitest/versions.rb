module Minitest
  module Versions
    MAJOR, MINOR, PATCH = Minitest::VERSION.split('.').map(&:to_i)
  end
end
