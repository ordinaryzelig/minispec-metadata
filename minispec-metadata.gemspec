# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minispec-metadata/version'

Gem::Specification.new do |gem|
  gem.name          = "minispec-metadata"
  gem.version       = MinispecMetadata::VERSION
  gem.authors       = ["Jared Ning"]
  gem.email         = ["jared@redningja.com"]
  gem.description   = %q{Minitest::Spec metadata}
  gem.summary       = %q{Pass metadata to Minitest::Spec descriptions and specs like in RSpec.}
  gem.homepage      = "https://github.com/ordinaryzelig/minispec-metadata"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'minitest'

  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'rake'
end
