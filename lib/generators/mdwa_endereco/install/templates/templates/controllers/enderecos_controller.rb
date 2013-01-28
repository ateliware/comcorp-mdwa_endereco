# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Endereco') 
@model = @entity.generator_model 
-%>
class A::EnderecosController < A::BackendController

  load_and_authorize_resource :class => "A::Endereco"
  
  # Hook for code generations. Do not delete.
  #===controller_init===

	def gerar_combobox_cidade
     @estado_id = params[:estado] unless params[:estado].blank?
     @cidades = A::Cidade.where( :estado_id => @estado_id )
     respond_to do |format| 
       format.js
     end
   end
   
   def atualizar_dados_cep
    begin
      @endereco = BuscaEndereco.por_cep(params[:cep])
      @tipo = params[:endereco_tipo]

      @estado = A::Estado.find_by_acronimo( @endereco[4].downcase )
      @cidade = A::Cidade.where( :nome => @endereco[3], :estado_id => @estado.id ).first
    rescue
    end
   
    respond_to do |format|
      format.js
    end
   end
	
end