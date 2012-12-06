Minispec::Metadata
==================

https://github.com/ordinaryzelig/minispec-metadata

## Usage

```ruby
describe 'Usage', some: 'metadata' do

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

end
```

## Installation

Add this line to your application's Gemfile:

    gem 'minispec-metadata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minispec-metadata
