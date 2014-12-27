require_relative 'helper'

describe MinispecMetadata do

  describe '#extract_metadata' do

    it 'extracts from a hash' do
      metadata = MinispecMetadata.extract_metadata [{asdf: true}]
      metadata.must_equal asdf: true
    end

    it 'extracts from symbols, returns hash keys with true values' do
      metadata = MinispecMetadata.extract_metadata [:asdf, :fdsa]
      metadata.must_equal asdf: true, fdsa: true
    end

    it 'extracts a mix' do
      metadata = MinispecMetadata.extract_metadata [:asdf, {fdsa: true}]
      metadata.must_equal asdf: true, fdsa: true
    end

    it 'does not remove metadata from args' do
      args = [:asdf, 'description']
      metadata = MinispecMetadata.extract_metadata args
      args.must_equal [:asdf, 'description']
    end

  end

end
