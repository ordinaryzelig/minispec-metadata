module MinispecMetadata

  module_function

  def tags
    @tags ||= []
  end

  def add_tag_string(tag_string)
    tags << Tag.new(tag_string)
  end

end

module MinispecMetadata

  module Tags

    def runnable_methods
      methods = super.dup

      if MinispecMetadata.tags.select(&:inclusive?).any?
        methods.select! do |runnable_method|
          runnable_method_matches_any_inclusive_tag?(runnable_method)
        end
      end

      methods.reject do |runnable_method|
        runnable_method_matches_any_exclusive_tag?(runnable_method)
      end
    end

    def runnable_method_matches_any_inclusive_tag?(runnable_method)
      tags = MinispecMetadata.tags.select(&:inclusive?)
      runnable_method_matches_any_tags?(runnable_method, tags)
    end

    def runnable_method_matches_any_exclusive_tag?(runnable_method)
      tags = MinispecMetadata.tags.select(&:exclusive?)
      runnable_method_matches_any_tags?(runnable_method, tags)
    end

  private

    def runnable_method_matches_any_tags?(runnable_method, tags)
      tags.any? do |tag|
        metadata = metadata_for_test_name(runnable_method)
        value = metadata[tag.key] || metadata[tag.key.to_sym]
        matches =
          if tag.value?
            value.to_s == tag.value
          else
            !!value
          end
        matches
      end
    end

  end

  class Tag

    def initialize(tag_string)
      @tag_string = tag_string
    end

    def exclusive?
      @tag_string.start_with? '~'
    end

    def inclusive?
      !exclusive?
    end

    def key
      @key ||= @tag_string[/\w+/]
    end

    def value
      @value ||= @tag_string.split(':').last if value?
    end

    def value?
      !!@tag_string[/:/]
    end

  end

end

Minitest::Test.singleton_class.send :prepend, MinispecMetadata::Tags
