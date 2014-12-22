require_relative 'helper'

describe MiniSpecMetadata::It do

  it 'stores metadata for current spec', meta: 'data' do
    metadata.fetch(:meta).must_equal 'data'
  end

  specify 'it works with #specify', 1 => 2 do
    metadata.fetch(1).must_equal 2
  end

  it 'returns empty hash when no metadata set' do
    metadata.must_equal({})
  end

  name = it 'returns name' do
    name.must_match /test_/
  end

  describe 'before/after hooks' do

    before do
      metadata.fetch(:before).must_equal 'accessible'
    end

    it 'is accessible in hooks', before: 'accessible', after: 'also accessible' do
      pass
    end

    after do
      metadata.fetch(:after).must_equal 'also accessible'
    end

  end

  it 'provides a method to get the name of the spec' do
    desc.must_equal 'provides a method to get the name of the spec'
  end

  describe 'with description metadata', description_meta: 'data' do

    it 'inherits metadata from description' do
      metadata.fetch(:description_meta).must_equal 'data'
    end

    #it "uses symbols as true values", :verity, :words_are_hard do
      #metadata.fetch(:verity).must_equal true
      #metadata.fetch(:words_are_hard).must_equal true
    #end

    describe 'in a nested describe', 'with no metadata' do

      it 'works', works: true do
        metadata.must_equal(description_meta: 'data', works: true)
      end

    end

    describe 'in a nested describe', with_metadata: true do

      it 'works', works: true do
        metadata.must_equal(works: true, with_metadata: true, description_meta: 'data')
      end

    end

    #it 'works if an "it" comes after a "describe" on the same level', works: true do
      #metadata.fetch(:description_meta).must_equal 'data'
      #metadata.fetch(:works).must_equal true
    #end

  end

end

#describe MiniSpecMetadata::SpecWithMetadata, 'additional description', :respect do

  #it 'respects additional description' do
    #self.class.name.must_equal 'MiniSpecMetadata::SpecWithMetadata::additional description'
    #metadata.must_equal({respect: true})
  #end

#end
