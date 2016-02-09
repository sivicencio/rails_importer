RailsImporter.setup do |config|
  # Add custom importer classes inheriting from RailsImporter::Base to importers array
  # You must define load_data method inside the importer class in order to use it
  # config.importers << ProductImporter
end
