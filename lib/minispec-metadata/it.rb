module MiniSpecMetadata
  module It

    def self.included(spec_class)
      spec_class.extend ClassMethods
    end

    module ClassMethods

      def it(description, metadata = {}, &block)
        name = super description, &block

        self.it_descriptions[name] = description
        self.metadata_by_test_name[name] = metadata

        name
      end
      alias_method :specify, :it

      def metadata_by_test_name
        @metadata_by_test_name ||= {}
      end

      def it_descriptions
        @it_descriptions ||= {}
      end

    end

    def metadata
      self.class.describe_metadata.merge(
        self.class.metadata_by_test_name.fetch(name)
      )
    end

    def desc
      self.class.it_descriptions.fetch(name)
    end

  end
end

Minitest::Spec.send :include, MiniSpecMetadata::It
