require_relative 'helper'

describe MinispecMetadata::Describe, super_meta: 'data' do

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

  describe 'when just a symbol is passed', :axiom, :vcr do
    it 'uses symbols as true values' do
      metadata.fetch(:axiom).must_equal true
      metadata.fetch(:vcr).must_equal true
    end
  end

  describe 'duplicate', first: '1st' do

    it 'correctly scopes metadata to current description' do
      metadata.must_equal(first: '1st', super_meta: 'data')
      metadata.key?(:second).must_equal false
    end

  end

  describe 'duplicate', second: '2nd' do

    it 'correctly scopes metadata to current description' do
      metadata.must_equal(second: '2nd', super_meta: 'data')
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

# Only allows 1 additional description.
describe MinispecMetadata::Describe, 'additional description' do

  it 'provides a method to get the descriptions' do
    self.class.descs.must_equal [MinispecMetadata::Describe, 'additional description']
  end

  it 'provides a method to get only the additional description' do
    self.class.additional_desc.must_equal ['additional description']
  end

  describe 'nested describe with no additional description' do

    it 'does not inherit additional description from parent' do
      self.class.additional_desc.must_be_empty
    end

  end

end

describe 'stuff', 'more stuff', {even_more: 'stuff'}, :holy_cow_that_is_a_lot_of_stuff, :minitest_5 do

  it 'preserves additional description but still allows any value for metadata', :more? => 'yeah' do
    self.class.descs.must_equal ['stuff', 'more stuff', {even_more: 'stuff'}, :holy_cow_that_is_a_lot_of_stuff, :minitest_5]
    metadata.must_equal(
      'more stuff'                     => true,
      :even_more                       => 'stuff',
      :holy_cow_that_is_a_lot_of_stuff => true,
      :more?                           => 'yeah',
      :minitest_5                      => true,
    )
  end

end

describe MinispecMetadata::Describe, 'additional description', :respect do

  it 'respects additional description' do
    self.class.name.must_equal 'MinispecMetadata::Describe::additional description::respect'
    metadata.must_equal(
      'additional description' => true,
      :respect                 => true,
    )
  end

end
