# -*- encoding : utf-8 -*-
===entity_code===
module A
	class Estado < ActiveRecord::Base

	    attr_accessible :nome, :acronimo, :pais, :pais_id
	  
	    belongs_to :pais, :class_name => 'A::Pais'
	    has_many :cidades, :class_name => 'A::Cidade'
	    
	    validates :nome, :acronimo, :pais_id, :presence => true
	    validates :acronimo, :uniqueness => true
	  
	end

end