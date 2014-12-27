module Minitest

  module Versions

    module_function

    [:major, :minor, :patch].each_with_index do |version, idx|
      version_int = Minitest::Unit::VERSION.split('.')[idx].to_i
      define_method version do
        version_int
      end
    end

  end

end
