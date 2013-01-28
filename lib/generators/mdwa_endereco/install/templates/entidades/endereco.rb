# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "Endereco" do |e|
  
  e.resource  = true
  e.ajax      = true
  e.scaffold_name = 'a/endereco'
  e.model_name = 'a/endereco'

  e.attribute 'rua', 'string'
  e.attribute 'numero', 'integer'
  e.attribute 'cep', 'string'
  e.attribute 'bairro', 'string'
  e.attribute 'complemento', 'string'
  
  e.association do |a|
    a.type = 'many_to_one'
    a.destination = 'Cidade'
  end

  e.collection_action :atualizar_dados_cep, :post, [:ajax]
  e.collection_action :gerar_combobx_cidade, :post, [:ajax]
  
end

MDWA::DSL.entity('Endereco').in_requirements << 'armazenar_enderecos'