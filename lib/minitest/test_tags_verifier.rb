# Ensure that when we're testing tags feature, it works as expected.

module Minitest

  def self.plugin_test_tags_verifier_init(options)
    Minitest.reporter << TestTagsVerifier.new(options.fetch(:tags))
  end

  class TestTagsVerifier < AbstractReporter

    def initialize(tags)
      @tags = tags
    end

    def results
      @results ||= []
    end

    def record(result)
      results << result
    end

    def report
      unless results.any?
        raise "No tests matching tags"
      end
      unless all_results_match_tags?
        raise "Expected all tests to have at least one tag matching #{MinispecMetadata.tags.map(&:inspect)}."
      end
    end

  private

    def all_results_match_tags?
      results.all? do |result|
        result.class.matches_any_tag?(result.name)
      end
    end

  end

end

Minitest.extensions << :test_tags_verifier 
