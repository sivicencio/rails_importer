class ImportJob < ActiveJob::Base
  queue_as :default

  def perform(importer_key, filepath)
    class_name = RailsImporter.importer_class(importer_key)
    class_name.new(filepath).process unless class_name.nil?
  end
end
