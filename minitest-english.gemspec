# coding: utf-8

Gem::Specification.new do |gem|
  gem.name       = 'minitest-english'
  gem.version    = '0.1.0'
  gem.author     = 'Dom Kiva-Meyer'
  gem.summary    = 'Minitest + the English language'
  gem.homepage   = 'http://github.com/domkm/minitest-english'
  gem.license    = 'MIT'

  gem.files      = `git ls-files`.split($/)
  gem.test_files = gem.files.grep(%r(^test/))

  gem.add_development_dependency 'bond'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'm'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'pry-awesome_print'
  gem.add_development_dependency 'pry-coolline'
  gem.add_development_dependency 'pry-debugger'
  gem.add_development_dependency 'pry-rescue'
  gem.add_development_dependency 'pry-stack_explorer'
  gem.add_development_dependency 'rake'
end
