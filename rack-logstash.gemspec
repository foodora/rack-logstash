# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/logstash/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-logstash'
  spec.version       = Rack::Logstash::VERSION
  spec.authors       = ['Stefan Rothlehner']
  spec.email         = ['stefan@foodora.com']

  spec.summary       = 'Rack request logger outputting logstash JSON format.'
  spec.description   = 'Rack::Logstash provides a simple request logger based on the standard Ruby library logger, outputting JSON into a log file.'
  spec.homepage      = 'https://github.com/foodora/rack-logstash'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack', '>= 0.4'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
