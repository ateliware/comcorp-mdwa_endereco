# -*- encoding : utf-8 -*-
===entity_code===
module A
	class Cidade < ActiveRecord::Base

	    attr_accessible :nome, :latitude, :longitude, :populacao, :estado, :estado_id

	    belongs_to :estado, :class_name => 'A::Estado'
	    has_many :bairros, :class_name => 'A::Bairro'
	    
	    validates :nome, :estado_id, :presence => true
	    
	    def nome_completo
	      "#{self.nome} - #{self.estado.acronimo.upcase}"
	    end
	  
	end
end