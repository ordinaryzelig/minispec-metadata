require_relative 'helper'

describe MiniSpecMetadata::SpecWithMetadata, description_meta: 'data' do

  it 'accepts metadata arg', {} do
    pass
  end

  it 'stores metadata for current spec', meta: 'data' do
    metadata.fetch(:meta).must_equal 'data'
  end

  it 'inherits metadata from description' do
    metadata.fetch(:description_meta).must_equal 'data'
  end

  specify 'it works with #specify', 1 => 2 do
    metadata.fetch(1).must_equal 2
  end

  name = it 'returns name' do
    name.must_equal name
  end

end

describe MiniSpecMetadata::SpecWithMetadata, 'with no metadata' do

  it 'returns empty hash when no metadata set' do
    metadata.must_equal({})
  end

end

describe MiniSpecMetadata::SpecWithMetadata do

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

describe MiniSpecMetadata::SpecWithMetadata, 'test name' do

  it 'provides a method to get the name of the spec' do
    spec_name.must_equal 'provides a method to get the name of the spec'
  end

end
