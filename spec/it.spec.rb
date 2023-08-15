require_relative 'helper'

describe MinispecMetadata::It do

  it 'stores metadata for current spec', meta: 'data' do
    _(metadata.fetch(:meta)).must_equal 'data'
  end

  specify 'it works with #specify', 1 => 2 do
    _(metadata.fetch(1)).must_equal 2
  end

  it 'returns empty hash when no metadata set' do
    _(metadata).must_equal({})
  end

  name = it 'returns name' do
    _(name).must_match %r/test_/
  end

  describe 'before/after hooks' do

    before do
      _(metadata.fetch(:before)).must_equal 'accessible'
    end

    it 'is accessible in hooks', before: 'accessible', after: 'also accessible' do
      pass
    end

    after do
      _(metadata.fetch(:after)).must_equal 'also accessible'
    end

  end

  describe 'with description metadata', description_meta: 'data' do

    it 'inherits metadata from description' do
      _(metadata.fetch(:description_meta)).must_equal 'data'
    end

    it "uses symbols as true values", :verity, :words_are_hard do
      _(metadata).must_equal(
        description_meta:  'data',
        verity:            true,
        words_are_hard:    true,
      )
    end

    describe 'in a nested describe', 'with no metadata' do

      it 'works', works: true do
        _(metadata).must_equal(
          :description_meta  => 'data',
          'with no metadata' => true,
          :works             => true,
        )
      end

    end

    describe 'in a nested describe', with_metadata: true do

      it 'works', works: true do
        _(metadata).must_equal(works: true, with_metadata: true, description_meta: 'data')
      end

    end

  end

end

describe MinispecMetadata::It, '#desc' do

  it 'provides a method to get the name of the spec' do
    _(desc).must_equal 'provides a method to get the name of the spec'
  end

end

