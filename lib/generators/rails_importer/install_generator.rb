module RailsImporter
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a RailsImporter initializer file at config/initializers"

      def copy_initializer
        template "rails_importer.rb", "config/initializers/rails_importer.rb"
      end

      def include_spree_importer_core_from_lib
        inject_into_file 'config/application.rb',
        "\n\t\t# Load application's importers"\
        "\n\t\tDir.glob(File.join(File.dirname(__FILE__), \"../lib/rails_importer/*_importer.rb\")) do |c|"\
        "\n\t\t\tRails.configuration.cache_classes ? require(c) : load(c)"\
        "\n\t\tend\n",
        :after => "< Rails::Application", :verbose => true
      end
    end
  end
end
