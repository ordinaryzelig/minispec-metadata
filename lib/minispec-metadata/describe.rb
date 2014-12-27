module MinispecMetadata
  module Describe

    def describe(desc, *additional_desc, &block)
      metadata = MinispecMetadata.extract_metadata additional_desc

      # Minitest 5 allows unlimited additional_desc.
      # Minitest 4 allows max 1 additional_desc.
      # So we need to pass up only the number of allowed additional_desc.
      additional_allowed =
        if Minitest::Versions::MAJOR <= 4
          additional_desc.first(1)
        else
          additional_desc
        end

      cls = super(desc, *additional_allowed.compact, &block)
      cls.extend ClassMethods

      cls.additional_desc = additional_desc
      cls.describe_metadata = metadata || {}

      cls
    end

    module ClassMethods

      attr_reader :additional_desc

      def describe_metadata
        super_describe_metadata =
          if superclass.respond_to? :describe_metadata
            superclass.describe_metadata
          else
            {}
          end
        super_describe_metadata.merge(@describe_metadata)
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
