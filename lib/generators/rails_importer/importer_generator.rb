module RailsImporter
  module Generators
    class ImporterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates an importer class inheriting from RailsImporter::Base"

      def add_importer_class
        template('importer.rb', "lib/rails_importer/#{file_name}_importer.rb")
      end

      def add_to_importers
        insert_into_file "config/initializers/rails_importer.rb", "\tconfig.importers << #{class_name}Importer\n", :before => "end"
      end
    end
  end
end
