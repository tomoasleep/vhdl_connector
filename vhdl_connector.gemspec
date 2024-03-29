# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vhdl_connector/version'

Gem::Specification.new do |spec|
  spec.name          = "vhdl_connector"
  spec.version       = VhdlConnector::VERSION
  spec.authors       = ["Tomoya Chiba"]
  spec.email         = ["tomo.asleep@gmail.com"]
  spec.description   = %q{Write commponent's definitions of VHDL automatically.}
  spec.summary       = %q{Write commponent's definitions of VHDL automatically.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "vhdl_parser"
end
