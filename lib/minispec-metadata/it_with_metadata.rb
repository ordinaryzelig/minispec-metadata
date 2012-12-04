module MiniSpecMetadata
  class ItWithMetadata < MiniTest::Spec

    @@metadata = {}

    def self.it(desc = 'anonymous', metadata = {}, &block)
      name = super desc, &block
      @@metadata[name] = metadata
      name
    end
    class << self
      alias :specify :it
    end

    def metadata
      description_metadata.merge @@metadata.fetch(__name__, {})
    end

  end
end

# Override the default spec type.
MiniTest::Spec::TYPES[0] = [//, MiniSpecMetadata::ItWithMetadata]
