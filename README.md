Minispec::Metadata
==================

[![Build Status](https://secure.travis-ci.org/ordinaryzelig/minispec-metadata.png?branch=master)](http://travis-ci.org/ordinaryzelig/minispec-metadata)

https://github.com/ordinaryzelig/minispec-metadata

## Usage

```ruby
require 'minitest/autorun'
require 'minispec-metadata'

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

  # Thanks to @mfpiccolo for this.
  it 'allows array of symbols like RSpec', :these, :work, :too do
    metadata[:these].must_equal true
    metadata[:work].must_equal true
    metadata[:too].must_equal true
  end

end
```

Another great use is to do a version of [Ryan Bates' VCR trick](http://railscasts.com/episodes/291-testing-with-vcr?view=asciicast).

```ruby
describe 'VCR trick' do
  it 'allows you to name your cassettes the same as the spec' do
    VCR.use_cassette spec_name do
    end
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'minispec-metadata'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install minispec-metadata

## Additional description gotcha

By default, Minitest allows 2 descriptions:

```ruby
describe 'Description 1', 'Description 2'
```

But this gem allows symbols as metadata:

```ruby
describe 'Description', :additional
```

Technically, this gem breaks Minitest behavior here.
With this gem, `:additional` is used as metadata.
But in pure Minitest, it would have been used as the additional description.
I personally have never seen anybody use the additional description,
and I think the "symbols as metadata" feature is more useful.
So I allowed this breakage of Minitest behavior.
