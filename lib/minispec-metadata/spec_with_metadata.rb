module MiniSpecMetadata
  module SpecWithMetadata

    def self.included(spec_class)
      spec_class.extend(ClassMethods)
    end

    module ClassMethods
      def it(desc = 'anonymous', _metadata = {}, &block)
        metadata =
          class_variable_defined?(:@@metadata) ?
            class_variable_get(:@@metadata) :
            class_variable_set(:@@metadata, {})
        spec_names =
          class_variable_defined?(:@@spec_names) ?
            class_variable_get(:@@spec_names) :
            class_variable_set(:@@spec_names, {})

        name = super desc, &block

        metadata[name] = _metadata
        spec_names[name] = desc
        name
      end
      alias_method :specify, :it
    end

    def metadata
      class_metadata = self.class.class_variable_get(:@@metadata).fetch(name, {})
      description_metadata.merge class_metadata
    end

    # First arg passed to it block.
    def spec_name
      self.class.class_variable_get(:@@spec_names)[name]
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

MiniTest::Spec.send :include, MiniSpecMetadata::SpecWithMetadata
