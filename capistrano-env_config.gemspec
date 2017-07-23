# encoding: utf-8

lib = File.expand_path( '../lib', __FILE__ )
$LOAD_PATH.unshift( lib ) unless $LOAD_PATH.include?( lib )

require 'capistrano/env_config/version'

Gem::Specification.new do |spec|
  spec.name        = 'capistrano-env_config'
  spec.version     = Capistrano::EnvConfig::VERSION
  spec.authors     = [ 'Itay Grudev' ]
  spec.email       = [ 'itay+capistrano-env_config+github.com[]grudev.com' ]
  spec.homepage    = 'https://github.com/itay-grudev/capistrano-env_config'
  spec.summary     = 'A tool for managing your environment variables across your cluster.'
  spec.description = <<-EOF
    EnvConfig is a tool for setting and syncing environment variables across
    your the servers in your cluster with a few simple Capistrano tasks.}
  EOF
  spec.license     = 'GPL-3.0'

  spec.rubyforge_project = 'capistrano-env_config'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = [ 'lib' ]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency 'capistrano', '~> 3.1'

  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'rake'
end