lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apollo/version'

Gem::Specification.new do |spec|
  spec.name          = 'apollo'
  spec.version       = Apollo::VERSION
  spec.authors       = ['Sagar Rohankar']
  spec.email         = ['sagar.rohankar@getblueshift.com']

  spec.description   = 'Ruby wrapper for the Apollo API'
  spec.summary       = 'Ruby wrapper for the Apollo API'
  spec.homepage      = ''

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'connection_pool'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'rubysl-ostruct'
  spec.add_runtime_dependency 'typhoeus'

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'uuidtools'
end
