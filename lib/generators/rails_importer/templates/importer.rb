class <%= class_name %>Importer < RailsImporter::Base
  # Load a file and the get data from each file row
  #
  # @params
  #   row   => A row to be processed
  def load_data(row:)
    # Implement this with custom logic. Otherwise, it will raise an exception
  end
end
