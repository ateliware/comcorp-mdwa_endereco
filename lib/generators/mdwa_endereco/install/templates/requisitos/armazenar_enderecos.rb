# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.requirements.register do |r|
  
  r.summary     = 'Armazenar endereços de entidades.'
  r.alias       = 'armazenar_enderecos'
  r.description = %q{Encapsula as funcionalidades de endereços.}
  
  r.entities    = ['Endereco', 'Cidade', 'Estado']
end
