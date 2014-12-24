require_relative 'helper'

# Confirmed to not work with v2.0.0.
# Thanks to @jrochkind.
describe "top level describe" do    
  describe "an inner describe" do
    before do
      desc.wont_be_nil
    end
    it "an example inside inner describe" do
      desc.must_equal 'an example inside inner describe'
    end
  end

  it "another top level example" do
    pass
  end
end
