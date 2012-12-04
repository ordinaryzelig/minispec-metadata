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

end
