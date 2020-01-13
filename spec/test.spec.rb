require_relative 'helper'
require 'minispec-metadata/test'

base_klass = Minitest::Versions::MAJOR >= 5 ? Minitest::Test : Minitest::Unit::TestCase

class TestMetaSpec < base_klass
  meta foo: :bar
  def test_metadata_returns_set_metadata
    assert_equal metadata.fetch(:foo), :bar
  end

  def test_metadata_returns_empty_hash_when_no_metadata_set
    assert_equal metadata, {}
  end

  meta :not_used
  def some_helper_method
    refute_includes metadata.keys, :not_used
  end

  def test_metadata_only_applies_to_test_methods
    some_helper_method
    refute_includes metadata.keys, :not_used
  end
end

class TestAllMetaSpec < base_klass
  meta_all :all

  meta :one
  def test_metadata_returns_meta_for_all_file_one
    assert_equal metadata.fetch(:all), true
    assert_equal metadata.fetch(:one), true
  end

  meta :two
  def test_metadata_returns_meta_for_all_file_two
    assert_equal metadata.fetch(:all), true
    assert_equal metadata.fetch(:two), true
  end
end

class TestLifecycleSpec < base_klass
  def setup
    assert_equal metadata.fetch(:setup), 'accessible'
  end

  meta setup: 'accessible', teardown: 'also accessible'
  def test_metadata_is_accessible_in_hooks
    pass
  end

  def teardown
    assert_equal metadata.fetch(:teardown), 'also accessible'
  end
end
