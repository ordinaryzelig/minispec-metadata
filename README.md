Minispec::Metadata
==================

[![Build Status](https://secure.travis-ci.org/ordinaryzelig/minispec-metadata.png?branch=master)](http://travis-ci.org/ordinaryzelig/minispec-metadata)

https://github.com/ordinaryzelig/minispec-metadata

## Usage

```ruby
describe 'Usage', some: 'metadata' do

  before do
    # Example usefulness:
    # Capybara.current_driver = metadata[:driver]
  end

  it 'defines a metadata method', more: 'metadata' do
    metadata.must_equal(
      some: 'metadata',
      more: 'metadata',
    )
  end

  it 'gives priority to closest metadata', some: 'different metadata' do
    metadata.must_equal(
      some: 'different metadata',
    )
  end

  it 'provides a method to get the name of the spec' do
    spec_name.must_equal 'provides a method to get the name of the spec'
  end

  describe MiniSpecMetadata::DescribeWithMetadata, 'additional description' do

    it 'provides a method to get the descriptions' do
      spec_descriptions.must_equal [MiniSpecMetadata::DescribeWithMetadata, 'additional description']
    end

    # I say "shortcut" because you can easily get this without this gem via
    # self.class.desc
    it 'provides a shortcut to get the main description' do
      spec_description.must_equal MiniSpecMetadata::DescribeWithMetadata
    end

    it 'provides a method to get only the additional description' do
      spec_additional_description.must_equal 'additional description'
    end

  end

end
```

## Installation

Add this line to your application's Gemfile:

    gem 'minispec-metadata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minispec-metadata

## Implementation (for transparency)

To add metadata to `it` blocks, I subclassed MiniTest::Spec.
In order to ensure that it gets used out of the box,
I changed the default Spec class to be the new subclass.

To add metadata to `describe` blocks, I included a module into the Object class.
