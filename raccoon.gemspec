# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raccoon/version'

Gem::Specification.new do |spec|
  spec.name          = "raccoon"
  spec.version       = Raccoon::VERSION
  spec.authors       = ["yulii"]
  spec.email         = ["yuliinfo@gmail.com"]
  spec.description   = %q{Scan controllers and views for Ruby on Rails}
  spec.summary       = %q{Testing controllers and views}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rspec-rails', '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
