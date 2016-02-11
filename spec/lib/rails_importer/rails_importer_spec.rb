require 'rails_helper'

describe RailsImporter do
  it { expect(RailsImporter).to respond_to :importers }
  it { expect(RailsImporter).to respond_to :router_name }

  it 'has a version number' do
    expect(RailsImporter::VERSION).not_to be nil
  end

  ###########
  # methods #
  ###########
  describe ".importer_class" do
    it { expect(RailsImporter).to respond_to :importer_class }

    context "when there are importers present" do
      it "returns the class associated to the passed keyname" do
        expect(RailsImporter.importer_class(:example)).to eq ExampleImporter
      end
    end

    context "when there are NO importers present" do
      before(:each) { allow(RailsImporter).to receive(:importers).and_return([]) }
      it "returns nil with any passed keyname" do
        expect(RailsImporter.importer_class(:keyname)).to be_nil
      end
    end
  end
end
