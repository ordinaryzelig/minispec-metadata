module MiniSpecMetadata
  module Describe

    def describe(desc, *additional_description, &block)
      metadata = additional_description.pop if additional_description.last.is_a?(Hash)

      cls = super(desc, *additional_description, &block)

      cls.extend ClassMethods
      cls.metadata_by_describe[desc] = metadata || {}

      cls
    end

    module ClassMethods

      def metadata_by_describe
        @metadata_by_describe ||= {}
      end

      def describe_metadata
        super_describe_metadata =
          if superclass.respond_to? :describe_metadata
            superclass.describe_metadata
          else
            {}
          end
        super_describe_metadata.merge(metadata_by_describe.fetch(desc))
      end

    end

  end
end

Object.send :include, MiniSpecMetadata::Describe
