# -*- encoding : utf-8 -*-
<%- 
@entity = MDWA::DSL.entity('Estado') 
@model = @entity.generator_model 
-%>
class <%= @model.controller_name %>Controller < <%= (@model.space == 'a') ? 'A::BackendController' : 'ApplicationController' %>

  <%- if @entity.resource? -%>
  load_and_authorize_resource :class => "<%= @model.klass %>"
  <%- end -%>
  
  # Hook for code generations. Do not delete.
  #===controller_init===

  def index
    conditions = []
    <%- 
    atributos_com_filtro = @entity.attributes.values.select {|attr| attr.options[:filtered]} 
    associacoes_com_filtro = @entity.associations.values.select {|assoc| assoc.options[:filtered]}
    -%>
    <%- if !atributos_com_filtro.count.zero? -%>
      <%- atributos_com_filtro.each do |atributo| -%>
        <%- if [:integer, :float, :decimal, :boolean].include? atributo.type.to_sym  -%>
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> = '#{params[:<%= atributo.name %>]}')" unless params[:<%= atributo.name %>].blank?
        <%- elsif [:string, :text].include? atributo.type.to_sym  -%>
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> LIKE '%#{params[:<%= atributo.name %>]}%')" unless params[:<%= atributo.name %>].blank?
        <%- elsif [:date].include? atributo.type.to_sym  -%>
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> BETWEEN '#{params[:<%= atributo.name %>_0].to_date}' AND '#{params[:<%= atributo.name %>_1].to_date}')" if !params[:<%= atributo.name %>_0].blank? and !params[:<%= atributo.name %>_1].blank?
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> >= '#{params[:<%= atributo.name %>_0].to_date}')" if !params[:<%= atributo.name %>_0].blank? and params[:<%= atributo.name %>_0].blank?
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> <= '#{params[:<%= atributo.name %>_1].to_date}')" if params[:<%= atributo.name %>_0].blank? and !params[:<%= atributo.name %>_1].blank?
        <%- elsif [:datetime, :timestamp].include? atributo.type.to_sym  -%>
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> BETWEEN '#{params[:<%= atributo.name %>_0].to_date.beginning_of_day}' AND '#{params[:<%= atributo.name %>_1].to_date.end_of_day}')" if !params[:<%= atributo.name %>_0].blank? and !params[:<%= atributo.name %>_1].blank?
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> >= '#{params[:<%= atributo.name %>_0].to_date.beginning_of_day}')" if !params[:<%= atributo.name %>_0].blank? and params[:<%= atributo.name %>_0].blank?
    conditions << "(<%= @model.plural_name %>.<%= atributo.name %> <= '#{params[:<%= atributo.name %>_1].to_date.end_of_day}')" if params[:<%= atributo.name %>_0].blank? and !params[:<%= atributo.name %>_1].blank?
        <%- end -%>
      <%- end -%>
    <%- end -%>

    <%- associacoes_com_filtro.each do |associacao| -%>
    conditions << "(<%= @model.plural_name %>.<%= associacao.name %>_id = #{params[:<%= associacao.name %>_id]})" unless params[:<%= associacao.name %>_id].blank?
    <%- end -%>

    @<%= @model.plural_name %> = <%= @model.klass %>.paginate :page => params[:page], :conditions => conditions.join(' AND ')

    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
    @<%= @model.singular_name %> = <%= @model.klass %>.find(params[:id])

  <%- if @entity.ajax? -%>
    render :layout => false
  <%- else -%>
    respond_to do |format|
      format.html
    end
  <%- end -%>
  end

  def new
    @<%= @model.singular_name %> = <%= @model.klass %>.new
    <%- @model.associations.select {|a| a.nested_one?}.each do |assoc| -%>
    @<%= @model.singular_name %>.<%= assoc.model2.singular_name %> = <%= assoc.model2.klass %>.new
    <%- end -%>

  <%- if @entity.ajax? -%>
    render :layout => false
  <%- else -%>
    respond_to do |format|
      format.html
    end
  <%- end -%>
  end

  def edit
    @<%= @model.singular_name %> = <%= @model.klass %>.find(params[:id])

  <%- if @entity.ajax? -%>
    render :layout => false
  <%- else -%>
    respond_to do |format|
      format.html
    end
  <%- end -%>
  end

  def create
    @<%= @model.singular_name %> = <%= @model.klass %>.new(params[:<%= @model.to_params %>])
    saved_ok = @<%= @model.singular_name %>.save
    @system_notice = t('<%= @model.plural_name %>.notice.create') if saved_ok    
  
  <%- @model.associations.select{|a| a.has_and_belongs_to_many? and a.composition?}.each do |association| -%>
    unless params[:<%= association.model2.plural_name %>].nil?
      @<%= @model.singular_name %>.<%= association.model2.plural_name %>.clear
      params[:<%= association.model2.plural_name %>].each do |<%= association.model2.singular_name.foreign_key %>|
        @<%= @model.singular_name %>.<%= association.model2.plural_name %>.push <%= association.model2.klass %>.find <%= association.model2.singular_name.foreign_key %>
      end
    end
  <%- end -%>

    respond_to do |format|
    <%- if @entity.ajax? -%>
      format.js
    <%- else -%>  
      if saved_ok
        format.html { redirect_to <%= @model.object_name.pluralize %>_path, notice: @system_notice }
      else
        format.html { render action: "new" }
      end
    <%- end -%>
    end
  end

  def update
    @<%= @model.singular_name %> = <%= @model.klass %>.find(params[:id])
  <%- if @entity.user? -%>
    # if password is blank, delete from params
    if params[:<%= @model.object_name %>][:password].blank?
      params[:<%= @model.object_name %>].delete :password
      params[:<%= @model.object_name %>].delete :password_confirmation
    end
  <%- end -%>
    @<%= @model.singular_name %>.attributes = params[:<%= @model.to_params %>]
    saved_ok = @<%= @model.singular_name %>.save
    @system_notice = t('<%= @model.plural_name %>.notice.update') if saved_ok
  
  <%- @model.associations.select{|a| a.has_and_belongs_to_many? and a.composition?}.each do |association| -%>
    unless params[:<%= association.model2.plural_name %>].nil?
      @<%= @model.singular_name %>.<%= association.model2.plural_name %>.clear
      params[:<%= association.model2.plural_name %>].each do |<%= association.model2.singular_name.foreign_key %>|
        @<%= @model.singular_name %>.<%= association.model2.plural_name %>.push <%= association.model2.klass %>.find <%= association.model2.singular_name.foreign_key %>
      end
    end
  <%- end -%>
    
    respond_to do |format|
    <%- if @entity.ajax? -%>
      format.js
    <%- else -%>
      if saved_ok
        format.html { redirect_to <%= @model.object_name.pluralize %>_path, notice: @system_notice }
      else
        format.html { render action: "edit" }
      end
    <%- end -%>
    end
  end

  def destroy
    @<%= @model.singular_name %> = <%= @model.klass %>.find(params[:id])
    @system_notice = t('<%= @model.plural_name %>.notice.destroy') if @<%= @model.singular_name %>.destroy
    
    respond_to do |format|
    <%- if @entity.ajax? -%>
      format.js
    <%- else -%>
      format.html { redirect_to <%= @model.object_name.pluralize %>_path, notice: @system_notice }
    <%- end -%>
    end
  end
  
  
end
