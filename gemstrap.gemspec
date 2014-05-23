# encoding: utf-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'gemstrap/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'gemstrap'
  s.version     = Gemstrap::VERSION
  s.authors     = ['André Dieb Martins']
  s.email       = ['andre.dieb@gmail.com']
  s.homepage    = 'https://github.com/dieb/gemstrap'
  s.summary     = 'Fastest way to bootstrap a new ruby gem.'
  s.description = 'Command-line tool for bootstraping a new ruby gem in seconds.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rspec', '~> 0'
end
