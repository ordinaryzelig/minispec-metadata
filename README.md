Minispec::Metadata
==================

[![Build Status](https://secure.travis-ci.org/ordinaryzelig/minispec-metadata.png?branch=master)](http://travis-ci.org/ordinaryzelig/minispec-metadata)

https://github.com/ordinaryzelig/minispec-metadata

## Usage

```ruby
# readme.spec.rb
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

  it 'provides a method to get the description of the spec' do
    desc.must_equal 'provides a method to get the description of the spec'
  end

  describe MinispecMetadata, 'additional description' do

    it 'provides a method to get the descriptions' do
      self.class.descs.must_equal [MinispecMetadata, 'additional description']
    end

    it 'provides a method to get only the additional description' do
      self.class.additional_desc.must_equal ['additional description']
    end

    it 'is not needed to get the described object' do
      # This is built in to Minitest, you don't need this gem to do this.
      self.class.desc.must_equal MinispecMetadata
    end

    it 'treats additional descriptions as metadata too', meta: 'data' do
      metadata.must_equal(
        :some                    => 'metadata',
        'additional description' => true,
        :meta                    => 'data',
      )
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
    VCR.use_cassette desc do
    end
  end
end
```

### Tags

(Only for Ruby >= 2 and Minitest >= 5)

Use the `--tag TAG` or `-tTAG` option to focus on certain tests according to metadata (only symbols as metadata keys).
E.g. Run only the slow tests below with option `--tag js`:

```ruby
describe 'integration tests' do
  it 'runs super slow JS stuff', :js do
    # Will run.
  end
  it 'runs fast stuff' do
    # Will not run.
  end
end
```

You can use `--tag` more than once to include more tags to be run (any matching tags will run).

If an exclusive tag, e.g. `~slow`, is used alone, all tests except those tagged slow will be run.
If an exclusive tag is used in addition to any inclusive tags, then the exclusive tag will just filter those included.

Note that when using `rake`, you need to wrap Minitest's options like this: `rake test TESTOPTS='--tag js'`.

## Installation

Add this line to your application's Gemfile:

    gem 'minispec-metadata'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install minispec-metadata

## Compatibility

Tested with Minitest 4 and up.
Might work with older versions but I haven't tested them.
See .travis to see Ruby versions tested.
