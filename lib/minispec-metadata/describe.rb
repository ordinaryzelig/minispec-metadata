module MinispecMetadata
  module Describe

    def describe(desc, *additional_desc, &block)
      metadata = MinispecMetadata.extract_metadata! additional_desc

      cls = super(desc, *additional_desc, &block)
      cls.extend ClassMethods

      cls.additional_desc = additional_desc
      cls.metadata_by_describe[desc] = metadata || {}

      cls
    end

    module ClassMethods

      attr_reader :additional_desc

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
        [desc, *additional_desc].compact
      end

      def additional_desc=(additional_desc)
        @additional_desc = additional_desc
        @additional_desc.freeze
      end

    end

  end
end

Object.send :include, MinispecMetadata::Describe
