# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "Cidade" do |e|
  
  e.resource  = true
  e.ajax      = true
  e.scaffold_name = 'a/cidade'
  e.model_name = 'a/cidade'
  
  e.attribute 'id', 'integer', {filtered: true}
  e.attribute 'nome', 'string', {default: true, filtered: true}
  e.attribute 'latitude', 'string'
  e.attribute 'longitude', 'string'
  e.attribute 'populacao', 'integer'
  
  e.association do |a|
    a.type = 'one_to_many'
    a.destination = 'Endereco' # entity name
  end
  
  e.association do |a|
    a.type = 'many_to_one'
    a.destination = 'Estado' # entity name
    a.options = {
      :filtered => true,
      :filter_field => 'nome'
    }
  end
  
end

MDWA::DSL.entity('Cidade').in_requirements << 'armazenar_enderecos'
