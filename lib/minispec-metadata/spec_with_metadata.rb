module MiniSpecMetadata
  class SpecWithMetadata < MiniTest::Spec

    @@metadata = {}
    @@spec_names = {}

    def self.it(desc = 'anonymous', metadata = {}, &block)
      name = super desc, &block
      @@metadata[name] = metadata
      @@spec_names[name] = desc
      name
    end
    class << self
      alias :specify :it
    end

    def metadata
      description_metadata.merge @@metadata.fetch(name, {})
    end

    # First arg passed to it block.
    def spec_name
      @@spec_names[name]
    end

    # Description args passed to describe.
    # Additional description is included if given.
    def spec_descriptions
      [spec_description, spec_additional_description].compact
    end

    def spec_description
      self.class.desc
    end

    def spec_additional_description
      self.class.spec_additional_description
    end

  end
end

# Override the default spec type.
MiniTest::Spec::TYPES[0] = [//, MiniSpecMetadata::SpecWithMetadata]
