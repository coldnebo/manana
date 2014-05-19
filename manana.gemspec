# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manana/version'

Gem::Specification.new do |spec|
  spec.name          = "manana"
  spec.version       = Manana::VERSION
  spec.authors       = ["coldnebo"]
  spec.email         = ["larry.kyrala@gmail.com"]
  spec.description   = %q{provides a simple way to defer initialization of an object until its methods are called}
  spec.summary       = %q{provides a simple way to defer initialization of an object until its methods are called}
  spec.homepage      = "https://github.com/coldnebo/manana"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
