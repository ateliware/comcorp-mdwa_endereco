# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Estado') 
@model = @entity.generator_model 
-%>
module A
	class Estado < ActiveRecord::Base

	    attr_accessible :nome, :acronimo, :pais
	  
	    has_many :cidades, :class_name => 'A::Cidade'
	    
	    validates :nome, :acronimo, :presence => true
	    validates :acronimo, :uniqueness => true
	  
	end

end