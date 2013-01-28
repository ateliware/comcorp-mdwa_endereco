# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mdwa_endereco/version'

Gem::Specification.new do |gem|
  gem.name          = "mdwa_endereco"
  gem.version       = MdwaEndereco::VERSION
  gem.authors       = ["QW3 Software"]
  gem.email         = ["contato@qw3.com.br"]
  gem.description   = %q{Cria o endereço no formato brasileiro}
  gem.summary       = %q{Cria endereço, cidade, estado e pais. Cria um db:seed com todas as cidades do Brasil.}
  gem.homepage      = "http://www.qw3.com.br"

  gem.rubyforge_project = "mdwa_endereco"
  
  gem.add_dependency 'rails', '>= 3.2.11'
  gem.add_dependency 'mdd', '>= 3.1.0'
  gem.add_dependency 'brcep'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
