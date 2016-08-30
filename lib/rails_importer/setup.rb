module RailsImporter
  module Setup
    # Importer classes
    mattr_accessor :importers
    @@importers = []

    mattr_accessor :router_name
    @@router_name = :main_app

    mattr_accessor :parent_controller_class

    def setup
      yield self if block_given?
    end

    def parent_controller_class
      @@parent_controller_class || ::ApplicationController
    end

    def importer_class(importer_key)
      @@importers.select{|i| i.key.to_s == importer_key.to_s}.first
    end
  end
end
