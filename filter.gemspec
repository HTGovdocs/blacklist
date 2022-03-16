# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "filter/version"

Gem::Specification.new do |spec|
  spec.name = "filter"
  spec.version = Filter::VERSION
  spec.authors = ["Josh Steverman"]
  spec.email = ["jstever@umich.edu"]
  spec.summary = 'Retrieval of list of bad/good OCLCs, good Authorities,
and rejected features.'
  spec.description = ""
  spec.homepage = ""
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
end
