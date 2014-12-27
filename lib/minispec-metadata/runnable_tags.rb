if Minitest::Versions::MAJOR >= 5 && RUBY_VERSION.to_i >= 2

  module MinispecMetadata
    class << self
      def tags
        @tags ||= []
      end
    end
  end

  module MinispecMetadata

    module RunnableTags

      def runnable_methods
        methods = super

        if MinispecMetadata.tags.any?
          methods.select do |runnable_method|
            matches_any_tag?(runnable_method)
          end
        else
          methods
        end
      end

      def matches_any_tag?(runnable_method)
        MinispecMetadata.tags.any? do |tag|
          metadata = metadata_for_test_name(runnable_method)
          metadata[tag]
        end
      end

    end

    Minitest::Test.singleton_class.send :prepend, RunnableTags

  end

end
