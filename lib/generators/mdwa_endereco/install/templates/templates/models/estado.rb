# -*- encoding : utf-8 -*-

class A::Estado < ActiveRecord::Base

    attr_accessible :nome, :acronimo

  
    has_many :cidades, :class_name => 'A::Cidade'
  
end