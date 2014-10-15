# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdmm2/version'

Gem::Specification.new do |spec|
  spec.name          = "rdmm2"
  spec.version       = RDMM2::VERSION
  spec.authors       = ["kinumi"]
  spec.email         = ["kunimi.ikeda@gmail.com"]
  spec.summary       = %q{A ruby client for DMM Web Service API 2.0}
  spec.description   = %q{A ruby client for DMM Web Service API 2.0}
  spec.homepage      = "https://github.com/kinumi/rdmm2"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
