# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'gifbot/version'

Gem::Specification.new do |s|
  s.name        = 'gifbot'
  s.version     = GifBot::VERSION
  s.authors     = ['blahed']
  s.email       = ['tdunn13@gmail.com']
  s.homepage    = ''
  s.summary     = 'Gif slinging IRC bot'
  s.description = 'Gif slinging IRC bot'

  s.rubyforge_project = 'gifbot'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_dependency('cinch', ['>= 0'])
  s.add_dependency('giphy', ['>= 0'])
end
