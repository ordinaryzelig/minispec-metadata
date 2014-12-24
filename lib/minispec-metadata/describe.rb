module MiniSpecMetadata
  module Describe

    def describe(desc, *additional_descriptions, &block)
      metadata = additional_descriptions.pop if additional_descriptions.last.is_a?(Hash)

      cls = super(desc, *additional_descriptions, &block)
      cls.extend ClassMethods

      cls.descs_additional = additional_descriptions
      cls.metadata_by_describe[desc] = metadata || {}

      cls
    end

    module ClassMethods

      attr_reader :descs_additional

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

      def descs
        [desc, *descs_additional].compact
      end

      def descs_additional=(additional_descriptions)
        @descs_additional = additional_descriptions
        @descs_additional.freeze
      end

    end

  end
end

Object.send :include, MiniSpecMetadata::Describe
