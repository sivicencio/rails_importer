class Import
  include ActiveModel::Model

  attr_accessor :importer_key, :import_file

  validates :importer_key, :import_file, presence: true

  def filepath
    import_file.respond_to?(:path) ? import_file.path : File.dirname(import_file)
  end
end
