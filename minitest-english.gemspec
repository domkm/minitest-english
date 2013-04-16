# coding: utf-8

Gem::Specification.new do |gem|
  gem.name       = 'minitest-english'
  gem.version    = '0.0.1'
  gem.author     = 'Dom Kiva-Meyer'
  gem.summary    = 'Minitest + the English language'
  gem.homepage   = 'http://github.com/domkm/minitest-english'
  gem.license    = 'MIT'

  gem.files      = `git ls-files`.split($/)
  gem.test_files = gem.files.grep(%r{^(test|spec)/})

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'm'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
end
