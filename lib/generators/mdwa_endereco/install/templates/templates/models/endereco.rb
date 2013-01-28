# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Endereco') 
@model = @entity.generator_model 
-%>
module A
  class Endereco < ActiveRecord::Base

      attr_accessible :rua, :numero, :cep, :complemento, :bairro
      
      validates :rua, :cep, :bairro, :presence => true
      
      def cidade
        self.bairro.cidade unless bairro.nil?
      end
      
      def nome_completo
        nome = []
        nome << self.rua
        nome << ", #{self.numero}" unless self.numero.blank?
        nome << " - #{self.complemento}" unless self.complemento.blank?
        nome << " - #{self.bairro}"
        nome << " - #{self.cep}"
        nome << " - #{self.cidade.nome_completo}"
        nome.join
      end
    
  end

end