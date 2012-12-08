require_relative 'helper'

describe MiniSpecMetadata::DescribeWithMetadata, super_meta: 'data' do

  describe 'as 2nd arg after description', second: '2nd' do

    it 'is accessible with metadata method' do
      metadata.fetch(:second).must_equal '2nd'
    end

  end

  describe 'as 3rd arg after additional description', 'more description', third: '3rd' do

    it 'is accessible with metadata method' do
      metadata.fetch(:third).must_equal '3rd'
    end

  end

  describe 'duplicate', first: '1st' do

    it 'correctly scopes metadata to current description' do
      metadata.fetch(:first).must_equal '1st'
      metadata.key?(:second).must_equal false
    end

  end

  describe 'duplicate', second: '2nd' do

    it 'correctly scopes metadata to current description' do
      metadata.fetch(:second).must_equal '2nd'
      metadata.key?(:first).must_equal false
    end

  end

  describe 'nested', sub: 'desc' do

    it 'inherits from surrounding description', lowest: 'totem' do
      metadata.must_equal(
        super_meta:  'data',
        sub:         'desc',
        lowest:      'totem',
      )
    end

    it 'gives nearest metadata priority', sub: 'zero', super_meta: 'priority' do
      metadata.must_equal(
        sub:         'zero',
        super_meta:  'priority',
      )
    end

  end

  desc_class = describe 'return value' do

    it 'equals description class' do
      desc_class.must_equal self.class
    end

  end

end

describe MiniSpecMetadata::DescribeWithMetadata, 'additional description' do

  it 'provides a method to get the descriptions' do
    spec_descriptions.must_equal [MiniSpecMetadata::DescribeWithMetadata, 'additional description']
  end

  it 'provides a shortcut to get the main description' do
    spec_description.must_equal MiniSpecMetadata::DescribeWithMetadata
  end

  it 'provides a method to get only the additional description' do
    spec_additional_description.must_equal 'additional description'
  end

  describe 'nested describe with no additional description' do

    it 'does not inherit additional description from parent' do
      spec_additional_description.must_be_nil
    end

  end

end
