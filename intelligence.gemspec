# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intelligence/version'

Gem::Specification.new do |spec|
  spec.name          = "intelligence"
  spec.version       = Intelligence::VERSION
  spec.authors       = ["Simon van Dyk"]
  spec.email         = ["simon.vandyk@gmail.com"]
  spec.summary       = %q{An example app to demonstrate various AI paradigms}
  spec.description   = %q{Example app for jozi ruby talk on artificial intelligence concepts such as genetic programming, neural networks and particle swarm optimization}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
