require 'minitest/spec'

require 'minitest/versions'
require_relative 'backwards'

require 'minispec-metadata/version'

require 'minispec-metadata/it'
require 'minispec-metadata/describe'

module MinispecMetadata

  module_function

  def extract_metadata(args)
    metadata = {}
    args.each do |arg|
      case arg
      when Hash
        metadata.merge! arg
      else
        metadata.merge!(arg => true)
      end
    end
    metadata
  end

  def supports_tags?
    minitest_version_supports_tags? && ruby_version_supports_tags?
  end

  # Because of plugin system.
  def minitest_version_supports_tags?
    Minitest::Versions::MAJOR >= 5
  end

  # Because of #prepend.
  def ruby_version_supports_tags?
    RUBY_VERSION.to_i >= 2
  end
end

MiniSpecMetadata = MinispecMetadata
