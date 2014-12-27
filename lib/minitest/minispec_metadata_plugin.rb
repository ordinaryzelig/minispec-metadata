require 'minispec-metadata'
require 'minispec-metadata/runnable_tags'

module Minitest

  def self.plugin_minispec_metadata_options(opts, options)
    opts.on '-t', '--tag TAG'do |tag|
      options[:tags] ||= []
      options[:tags] << tag.to_sym
    end
  end

  def self.plugin_minispec_metadata_init(options)
    if RUBY_VERSION.to_i >= 2
      MinispecMetadata.tags.concat options.fetch(:tags, [])
    else
      warn 'tags requires Ruby 2. If you really want it, please open an issue'
    end
  end

end

require_relative 'test_tags_verifier' if ENV['TEST_TAGS'] && Minitest::Versions::MAJOR >= 5
