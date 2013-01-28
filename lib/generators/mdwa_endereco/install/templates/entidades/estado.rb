# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "Estado" do |e|
  
  e.resource  = true
  e.ajax      = true
  e.scaffold_name = 'a/estado'
  e.model_name = 'a/estado'

  e.attribute 'nome', 'string'
  e.attribute 'acronimo', 'string'
  
  e.association do |a|
    a.type = 'one_to_many'
    a.destination = 'Cidade'
  end
  
end

MDWA::DSL.entity('Estado').in_requirements << 'armazenar_enderecos'