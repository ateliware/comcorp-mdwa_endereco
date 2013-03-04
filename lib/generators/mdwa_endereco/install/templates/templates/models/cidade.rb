# -*- encoding : utf-8 -*-
class A::Cidade < ActiveRecord::Base

  attr_accessible :nome, :latitude, :longitude, :populacao, :estado

  has_many :enderecos, :class_name => 'A::Endereco'
  belongs_to :estado, :class_name => 'A::Estado'
  attr_accessible :estado_id

  def nome_completo
    "#{nome} - #{estado.acronimo.upcase}"
  end
  
end