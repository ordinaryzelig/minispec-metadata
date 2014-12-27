require_relative 'helper'
require_relative 'test_tags_verifier' if ENV['TEST_TAGS'] && MinispecMetadata.supports_tags?

module MinispecMetadata
  describe Tag do

    it 'captures the metadata key' do
      tag = Tag.new('~sure')
      tag.key.must_equal :sure
      tag.value?.must_equal false
    end

    it 'captures metadata key/value' do
      tag = Tag.new('key:value')
      tag.key.must_equal   :key
      tag.value.must_equal 'value'
    end

    it 'captures inclusivity' do
      tag = Tag.new('sure')
      tag.must_be :inclusive?
    end

    it 'captures exclusivity' do
      tag = Tag.new('~sure')
      tag.must_be :exclusive?
    end

  end
end

describe 'minitest >= 5', :minitest_5 do

  it 'runs for Minitest >= v5' do
    pass
  end

  it 'runs slow for Minitest >= v5', :slow do
    pass
  end

end

describe 'minitest <= 4', :minitest_4 do

  it 'runs for Minitest <= v4' do
    pass
  end

  it 'runs slow for Minitest <= v4', :slow do
    pass
  end

end

describe 'specific tag value' do

  it 'matches by matched tag value', specific: 'value' do
    pass
  end

  it 'matches by matched and unmatched tag value', specific: 'value', unmatched: 'value' do
    pass
  end

  it 'matches by unmatched tag value (slow)', :slow, specific: 'value' do
    pass
  end

end
