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

end
```

### Gotchas

If you registered a custom spec type and made it a subclass of MiniTest::Spec, e.g.:

```ruby
class IntegrationSpec < MiniTest::Spec
  register_spec_type(/integration$/, self)
end
MiniTest
```

then you will need to change your superclass to be a subclass of the spec type that allows metadata
(see Implementation below).
Just change it like this:

```ruby
class IntegrationSpec < MiniTest::Spec.spec_type(//)
  register_spec_type(/integration$/, self)
end
MiniTest
```

`MiniTest::Spec.spec_type` will always give you the top-level spec type, even if you don't use this gem.

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
