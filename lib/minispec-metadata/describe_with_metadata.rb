module MiniSpecMetadata
  module DescribeWithMetadata

    def describe(desc, *_args, &block)
      args = _args.dup

      metadata =
        case args.last
        when Hash
          args.pop
        when Symbol
          # We're changing Minitest behavior here.
          # If args.first is anything but a Symbol, use it as additional_description.
          # If it's a symbol, assume it is metadata.
          additional_description = args.shift unless args.first.is_a?(Symbol)
          args.each_with_object({}) do |arg, hash|
            hash[arg] = true
          end
        else
          {}
        end

      additional_description ||= args.first
      description_class = super(desc, additional_description, &block)

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
