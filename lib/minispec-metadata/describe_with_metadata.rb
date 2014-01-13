module MiniSpecMetadata
  module DescribeWithMetadata

    def describe(desc, *args, &block)
      if args.last.is_a?(Hash)
        metadata = args.pop
      elsif args.last.is_a?(Symbol)
        metadata = { args.last => true }
      else
        metadata = {}
      end

      additional_description = args.first
      description_class = super(desc, args, &block)

      description_class.send :define_method, :description_metadata do
        super().merge(metadata)
      end

      description_class.send :define_method, :spec_additional_description do
        additional_description
      end

      description_class
    end

    # Top-level method so all subclasses can call super.
    def description_metadata
      {}
    end

  end
end

Object.send :include, MiniSpecMetadata::DescribeWithMetadata
