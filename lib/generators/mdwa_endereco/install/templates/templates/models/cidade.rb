# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Cidade') 
@model = @entity.generator_model 
-%>
module A
	class Cidade < ActiveRecord::Base

	    attr_accessible :nome, :latitude, :longitude, :populacao, :estado, :estado_id

	    belongs_to :estado, :class_name => 'A::Estado'
	    
	    validates :nome, :estado_id, :presence => true
	    
	    def nome_completo
	      "#{self.nome} - #{self.estado.acronimo.upcase}"
	    end
	  
	end
end