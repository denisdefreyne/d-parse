# frozen_string_literal: true

require_relative 'lib/d-parse/version'

Gem::Specification.new do |s|
  s.name        = 'd-parse'
  s.version     = DParse::VERSION
  s.homepage    = 'http://rubygems.org/gems/d-parse'
  s.summary     = 'parser combinator library'
  s.description = 'D★Parse is a library for building parser combinators.'

  s.author  = 'Denis Defreyne'
  s.email   = 'denis.defreyne@stoneship.org'
  s.license = 'MIT'

  s.files =
    Dir['[A-Z]*'] +
    Dir['{lib,spec,samples}/**/*'] +
    ['d-parse.gemspec']
  s.require_paths = ['lib']

  s.rdoc_options     = ['--main', 'README.md']
  s.extra_rdoc_files = ['LICENSE', 'README.md', 'NEWS.md']

  s.required_ruby_version = '>= 2.1.0'

  s.add_development_dependency('bundler', '>= 1.11.2', '< 2.0')
end
