require 'minitest/spec'

require 'minitest/versions'
require_relative 'backwards'

require 'minispec-metadata/version'

require 'minispec-metadata/it'
require 'minispec-metadata/describe'
require 'minispec-metadata/tags'

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

end

MiniSpecMetadata = MinispecMetadata
