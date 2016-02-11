module RailsImporter
  module Setup
    # Importer classes
    mattr_accessor :importers
    @@importers = []

    mattr_accessor :router_name
    @@router_name = :main_app

    def setup
      yield self if block_given?
    end

    def importer_class(importer_key)
      @@importers.select{|i| i.key.to_s == importer_key.to_s}.first
    end
  end
end
