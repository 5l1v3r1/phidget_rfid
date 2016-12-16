# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phidget_rfid/version'

Gem::Specification.new do |spec|
  spec.name          = "phidget_rfid"
  spec.version       = PhidgetRfid::VERSION
  spec.authors       = ["Luis Fontes"]
  spec.email         = ["mail.fontes@gmail.com"]

  spec.summary       = %q{PHIDGET RFID wrapper}
  spec.description   = %q{A simple console app to work with PHIDGET RFID.}
  spec.homepage      = "https://github.com/luisfontes19/phidget_rfid"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = 'phidget_rfid'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "highline"
  spec.add_dependency "cli-console"
  spec.add_dependency "phidgets-ffi"
end
