module MinispecMetadata
  module Describe

    def describe(desc, *additional_desc, &block)
      metadata = MinispecMetadata.extract_metadata additional_desc

      additional_allowed = additional_desc

      cls = super(desc, *additional_allowed.compact, &block)
      cls.extend ClassMethods

      cls.additional_desc = additional_desc
      cls.describe_metadata = metadata || {}

      cls
    end

    module ClassMethods

      attr_reader :additional_desc

      def describe_metadata
        @describe_metadata ||= {}
        if superclass.respond_to?(:describe_metadata)
          superclass.describe_metadata.merge(@describe_metadata)
        else
          @describe_metadata
        end
      end

      def descs
        [desc, *additional_desc].compact
      end

      def additional_desc=(additional_desc)
        @additional_desc = additional_desc.freeze
      end

      def describe_metadata=(metadata)
        @describe_metadata = metadata.freeze
      end

    end

  end
end

Object.send :include, MinispecMetadata::Describe
