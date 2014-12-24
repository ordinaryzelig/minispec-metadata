require_relative 'helper'

describe MiniSpecMetadata do

  describe '#extract_metadata!' do

    it 'extracts from a hash' do
      metadata = MiniSpecMetadata.extract_metadata! [{asdf: true}]
      metadata.must_equal asdf: true
    end

    it 'extracts from symbols, returns hash keys with true values' do
      metadata = MiniSpecMetadata.extract_metadata! [:asdf, :fdsa]
      metadata.must_equal asdf: true, fdsa: true
    end

    it 'extracts a mix' do
      metadata = MiniSpecMetadata.extract_metadata! [:asdf, {fdsa: true}]
      metadata.must_equal asdf: true, fdsa: true
    end

    it 'descructively removes metadata from args' do
      args = [:asdf, 'description']
      metadata = MiniSpecMetadata.extract_metadata! args
      args.must_equal ['description']
    end

  end

end
