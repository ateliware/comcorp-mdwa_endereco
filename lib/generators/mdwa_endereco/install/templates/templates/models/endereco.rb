# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Endereco') 
@model = @entity.generator_model 
-%>
module A
  class Endereco < ActiveRecord::Base

      attr_accessible :rua, :numero, :cep, :complemento, :bairro, :cidade_id

      belongs_to :cidade, :class_name => 'A::Cidade'
      
      validates :rua, :cep, :bairro, :cidade_id, :presence => true
      
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
