# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ft/version"

Gem::Specification.new do |spec|
  spec.name          = "ft"
  spec.version       = FT::VERSION
  spec.authors       = ["Emil Shakirov"]
  spec.email         = ["5o.smoker@gmail.com"]

  spec.summary       = "FT — from origin to destination"
  spec.description   = "FT — a small toy library, that translates flight search sentence to computer readable parameters."
  spec.homepage      = "https://github.com/vaihtovirta/ft"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "daybreak"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "damerau-levenshtein"
  spec.add_runtime_dependency "fuzzy_match"
  spec.add_runtime_dependency "ruby-stemmer"
  spec.add_runtime_dependency "unicode"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "smarter_csv"
end
