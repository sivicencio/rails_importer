# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_importer/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_importer"
  spec.version       = RailsImporter::VERSION
  spec.authors       = ["Sebastián Vicencio"]
  spec.email         = ["sivicencio@gmail.com"]

  spec.summary       = %q{Import engine for Rails}
  spec.description   = %q{Define importers for massive spreadsheet/csv load of data, based on your needs}
  spec.homepage      = "https://github.com/sivicencio/rails_importer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2"
  spec.add_dependency "roo", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
