require_relative 'helper'

module MinispecMetadata
  describe Tag do

    it 'captures the metadata key' do
      tag = Tag.new('~sure')
      _(tag.key).must_equal( 'sure')
      _(tag.value?).must_equal false
    end

    it 'captures metadata key/value' do
      tag = Tag.new('key:value')
      _(tag.key).must_equal(   'key')
      _(tag.value).must_equal( 'value')
    end

    it 'captures inclusivity' do
      tag = Tag.new('sure')
      _(tag).must_be :inclusive?
    end

    it 'captures exclusivity' do
      tag = Tag.new('~sure')
      _(tag).must_be :exclusive?
    end

    it 'captures exclusivity' do
      tag = Tag.new('~sure')
      tag.must_be :exclusive?
    end

  end

  TAGS_TEST = describe Tags do
    def self.passing_test(*args)
      it *args do
        pass
      end
    end

    passing_test '1', :minitest_5
    passing_test '2', 'minitest_5', :slow
    passing_test '3', :minitest_4
    passing_test '4', :minitest_4, 'slow'
    passing_test '5', :slow, specific: 'value'
    passing_test '6', 'specific' => :value, unmatched: :value
    passing_test '7', 'specific' => 'value'
  end

  # Test the #runnable_methods of tags_test above with different sets of Tags.
  describe '#runnable_methods' do

    def stub_tags(tag_strings, &block)
      tags = tag_strings.map { |tag_string| Tag.new(tag_string) }
      MinispecMetadata.stub :tags, tags, &block
    end

    def strip_prefix(name)
      name.sub /^test_\d{4}_/, ''
    end

    def self.assert_runnable_methods_with_tags(tag_strings, expected_runnable_methods)
      it "returns runnable_methods with tag_strings #{tag_strings.inspect}" do
        stub_tags tag_strings do
          _(TAGS_TEST
            .runnable_methods
            .map(&method(:strip_prefix))
            .sort)
          .must_equal expected_runnable_methods
        end
      end
    end

    assert_runnable_methods_with_tags ['minitest_5'], %w[
      1
      2
    ]

    assert_runnable_methods_with_tags ['~minitest_4'], %w[
      1
      2
      5
      6
      7
    ]

    assert_runnable_methods_with_tags ['specific:value'], %w[
      5
      6
      7
    ]

    assert_runnable_methods_with_tags ['~unmatched:value'], %w[
      1
      2
      3
      4
      5
      7
    ]

    assert_runnable_methods_with_tags ['minitest_5', 'minitest_4', 'specific:value', '~unmatched:value', '~slow'], %w[
      1
      3
      7
    ]

  end

end
