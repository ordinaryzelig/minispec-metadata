require_relative 'helper'
require 'minispec-metadata/test'

class TestMetaSpec < Minitest::Test
  meta foo: :bar
  def test_metadata_returns_set_metadata
    metadata.fetch(:foo).must_equal :bar
  end

  def test_metadata_returns_empty_hash_when_no_metadata_set
    metadata.must_equal({})
  end

  meta :not_used
  def some_helper_method
    metadata.keys.wont_include :not_used
  end

  def test_metadata_only_applies_to_test_methods
    some_helper_method
    metadata.keys.wont_include :not_used
  end
end

class TestAllMetaSpec < Minitest::Test
  meta_all :all

  meta :one
  def test_metadata_returns_meta_for_all_file_one
    metadata.fetch(:all).must_equal true
    metadata.fetch(:one).must_equal true
  end

  meta :two
  def test_metadata_returns_meta_for_all_file_two
    metadata.fetch(:all).must_equal true
    metadata.fetch(:two).must_equal true
  end
end

class TestLifecycleSpec < Minitest::Test
  def setup
    metadata.fetch(:setup).must_equal 'accessible'
  end

  meta setup: 'accessible', teardown: 'also accessible'
  def test_metadata_is_accessible_in_hooks
    pass
  end

  def teardown
    metadata.fetch(:teardown).must_equal 'also accessible'
  end
end
