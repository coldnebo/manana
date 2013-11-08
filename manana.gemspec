# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manana/version'

Gem::Specification.new do |spec|
  spec.name          = "manana"
  spec.version       = Manana::VERSION
  spec.authors       = ["coldnebo"]
  spec.email         = ["larry.kyrala@gmail.com"]
  spec.description   = %q{provides a simple way to defer initialization of an object to action on an object}
  spec.summary       = %q{I'll get to your initialization tomorrow...}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
