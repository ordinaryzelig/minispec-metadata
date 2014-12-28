# This file gets auto required/executed by Minitest >= v5.
# Any other version won't find this file automatically.

require 'minispec-metadata'

module Minitest

  def self.plugin_minispec_metadata_options(opts, options)
    opts.on '-t', '--tag TAG'do |tag_string|
      options[:tag_strings] ||= []
      options[:tag_strings] << tag_string
    end
  end

  def self.plugin_minispec_metadata_init(options)
    if RUBY_VERSION.to_i >= 2
      options.fetch(:tag_strings, []).each do |tag_string|
        MinispecMetadata.add_tag_string tag_string
      end
    else
      warn 'tags requires Ruby 2. If you really want it, please open an issue.'
    end
  end

end
