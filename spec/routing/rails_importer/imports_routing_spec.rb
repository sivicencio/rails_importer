require "rails_helper"

RSpec.describe RailsImporter::ImportsController, :type => :routing do

  routes { RailsImporter::Engine.routes }

  describe "routing" do
    it "routes to #new" do
      expect(:get => "/importers/importer/new").to route_to(controller: "rails_importer/imports", action: 'new', importer_key: "importer")
    end

    it "routes to #create" do
      expect(:post => "/importers/importer").to route_to(controller: "rails_importer/imports", action: 'create', importer_key: "importer")
    end

    it "routes to #sample" do
      expect(:get => "/importers/importer/sample").to route_to(controller: "rails_importer/imports", action: 'sample', importer_key: "importer")
    end
  end
end
