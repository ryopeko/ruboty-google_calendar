# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/google_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-google_calendar"
  spec.version       = Ruboty::GoogleCalendar::VERSION
  spec.authors       = ["Ryoichi SEKIGUCHI"]
  spec.email         = ["ryopeko+free@gmail.com"]
  spec.summary       = %q{Google Calendar API Wrapper for ruboty}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty", ">= 0.2.0"
  spec.add_dependency "google-api-client"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
