require 'minitest/test'

module MinispecMetadata
  module Test
    def self.included(test_class)
      test_class.extend ClassMethods
    end

    module ClassMethods
      def meta(*metadata)
        self.last_defined_metadata = MinispecMetadata.extract_metadata(metadata)
      end

      def last_defined_metadata
        @last_defined_metadata || {}
      end

      def last_defined_metadata=(value)
        @last_defined_metadata = value
      end

      def metadata_by_test_name
        @metadata_by_test_name ||= {}
      end

      def method_added(method_name)
        method_name = method_name.to_s
        if method_name.start_with?("test_")
          metadata_by_test_name[method_name] = last_defined_metadata
        end

        self.last_defined_metadata = nil
      end

      def meta_all(*metadata)
        new_metadata = MinispecMetadata.extract_metadata(metadata)
        warn "Overwriting test metadata for #{self}: #{@metadata_for_all_tests} => #{new_metadata}" unless metadata_for_all_tests.empty?
        @metadata_for_all_tests = new_metadata
      end

      def metadata_for_all_tests
        @metadata_for_all_tests || {}
      end

      def metadata_for_test_name(test_name)
        metadata_for_all_tests.merge(
          metadata_by_test_name.fetch(test_name)
        )
      end
    end

    def metadata
      self.class.metadata_for_test_name(name)
    end
  end
end

Minitest::Test.send :include, MinispecMetadata::Test
