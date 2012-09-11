# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'vidibus/core_extensions/version'

Gem::Specification.new do |s|
  s.name        = 'vidibus-core_extensions'
  s.version     = Vidibus::CoreExtensions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = 'André Pankratz'
  s.email       = 'andre@vidibus.com'
  s.homepage    = 'https://github.com/vidibus/vidibus-core_extensions'
  s.summary     = 'Provides some extensions of the Ruby core'
  s.description = s.summary

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = s.name

  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '~> 2'
  s.add_development_dependency 'rr'
  s.add_development_dependency 'simplecov'

  s.files = Dir.glob('{lib,app,config}/**/*') + %w[LICENSE README.md Rakefile]
  s.require_path = 'lib'
end
