require 'minitest/spec'
require_relative 'backwards'

require "minispec-metadata/version"

require 'minispec-metadata/it'
require 'minispec-metadata/describe'

module MinispecMetadata

  module_function

  def extract_metadata!(args)
    metadata = {}
    args.delete_if do |arg|
      case arg
      when Hash
        metadata.merge! arg
      when Symbol
        metadata.merge!(arg => true)
      else
        false
      end
    end
    metadata
  end

end

MiniSpecMetadata = MinispecMetadata
