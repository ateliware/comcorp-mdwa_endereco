# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'mdwa/dsl'

module MdwaEndereco
	class InstallGenerator < Rails::Generators::Base

		source_root File.expand_path("../templates", __FILE__)

		def mdwa

			# Dependência da gem brcep para geolocalização
			gem 'brcep'
			run 'bundle install'

			# Copia o requisito
			copy_file 'requisitos/armazenar_enderecos.rb', MDWA::DSL::REQUIREMENTS_PATH + 'armazenar_enderecos.rb'

			# Copia as entidades
			copy_file 'entidades/endereco.rb', MDWA::DSL::STRUCTURAL_PATH + 'endereco.rb'
			copy_file 'entidades/cidade.rb', MDWA::DSL::STRUCTURAL_PATH + 'cidade.rb'
			copy_file 'entidades/estado.rb', MDWA::DSL::STRUCTURAL_PATH + 'estado.rb'

		end

		def templates
			# Models
			copy_file 'templates/models/cidade.rb', MDWA::DSL::TEMPLATES_PATH + 'cidade/a/model.erb'
			copy_file 'templates/models/estado.rb', MDWA::DSL::TEMPLATES_PATH + 'estado/a/model.erb'
			copy_file 'templates/models/endereco.rb', MDWA::DSL::TEMPLATES_PATH + 'endereco/a/model.erb'

			# Model Geoposicionamento
			copy_file 'templates/models/geoposicionamento.rb', 'app/models/geoposicionamento.rb'

			# Controllers
			copy_file 'templates/controllers/cidades_controller.rb', MDWA::DSL::TEMPLATES_PATH + 'cidade/a/controller.erb'
			copy_file 'templates/controllers/estados_controller.rb', MDWA::DSL::TEMPLATES_PATH + 'estado/a/controller.erb'
			copy_file 'templates/controllers/enderecos_controller.rb', MDWA::DSL::TEMPLATES_PATH + 'endereco/a/controller.erb'

			# Helpers
			copy_file 'templates/helpers/cidade.rb', MDWA::DSL::TEMPLATES_PATH + 'cidade/a/helper.erb'
			copy_file 'templates/helpers/estado.rb', MDWA::DSL::TEMPLATES_PATH + 'estado/a/helper.erb'
			copy_file 'templates/helpers/endereco.rb', MDWA::DSL::TEMPLATES_PATH + 'endereco/a/helper.erb'

			# Views
			directory 'templates/views/cidades', MDWA::DSL::TEMPLATES_PATH + 'cidade/a/views'
			directory 'templates/views/estados', MDWA::DSL::TEMPLATES_PATH + 'estado/a/views'
			directory 'templates/views/enderecos', MDWA::DSL::TEMPLATES_PATH + 'endereco/a/views'

		end

		def assets
			copy_file 'assets/js/endereco.js', 'app/assets/javascripts/qw3/mdwa_endereco.js'
		end

		def locales

			copy_file 'locales/mdwa.endereco.en.yml', 'config/locales/mdwa.endereco.en.yml' unless File.exists?(Rails.root + 'config/locales/mdwa.endereco.en.yml')
			copy_file 'locales/mdwa.endereco.pt-BR.yml', 'config/locales/mdwa.endereco.pt-BR.yml' unless File.exists?(Rails.root + 'config/locales/mdwa.endereco.pt-BR.yml')

		end

		def rodar_transformacao
			if yes? "Deseja rodar a transformação dos templates de endereço, cidade e estado?"
				generate "mdwa:transform Estado Cidade Endereco --skip-locales"
			end
		end

		def db_seeds
			copy_file 'db/seeds.rb', 'db/seeds/enderecos.rb'
      append_file 'db/seeds.rb' do
         "\n
if A::Cidade.count.zero?
 require File.expand_path( '../seeds/enderecos', __FILE__ )
end
         \n"
      end
			if yes? "Deseja rodar rake db:seed?"
				rake 'db:seed'
			end
		end

	end
end
