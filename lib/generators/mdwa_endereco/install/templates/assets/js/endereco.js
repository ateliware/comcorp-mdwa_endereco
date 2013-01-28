$(function() {

	$(document).on("change", "#estado_id", function() {
		var me = $(this);
		 $.ajax({
			url: '/a/enderecos/gerar_combobox_cidade',
			type: 'POST',
			data: {
				'estado' : me.val(), 
				'endereco_tipo': $("#endereco_tipo").val(),
				'somente_cidade': $('#somente_cidade').val()
			},
			dataType: 'script'
		 });
	});

	$(document).on("blur", "input.endereco_cep_ajax", function {
	  if( $(this).val() != "" ) {
		var me = $(this);
	    $.ajax({
			  url: "/a/enderecos/atualizar_dados_cep", 
			  method: "POST",
			  data: {
				  'cep': me.val(),
				  'endereco_tipo': $("#endereco_tipo").val()
			  },
			  beforeSend: function() {
				  $('input.endereco_cep_ajax').parent().append('<span><img src="<%= asset_path 'mdwa/barra-16.gif' %>" alt="Carregando..." /></span>');
			  }
		  });
	  }
	});
	
});

