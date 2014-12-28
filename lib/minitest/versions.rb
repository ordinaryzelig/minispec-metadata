module Minitest

  module Versions

    MAJOR, MINOR, PATCH = Minitest::Unit::VERSION.split('.').map(&:to_i)

  end

end
