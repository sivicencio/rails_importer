require 'rails_helper'

RSpec.describe RailsImporter::Base do
  let(:import) { FactoryGirl.build(:import, importer_key: 'example') }

  subject { RailsImporter::Base.new(import.filepath) }

  ###############
  # attributes #
  ##############
  it { expect(subject).to respond_to :messages }

  ###########
  # methods #
  ###########
  describe ".initialize" do
    context "when filepath is valid" do
      it "opens the specified spreadsheet" do
        allow_any_instance_of(RailsImporter::Base).to receive(:open_spreadsheet)
        expect_any_instance_of(RailsImporter::Base).to receive(:open_spreadsheet)
        base = RailsImporter::Base.new(import.filepath)
      end

      it "has an empty error messages array" do
        expect(subject.messages).to be_empty
      end
    end

    context "when filepath is invalid" do
      it "tries to open the specified spreadsheet" do
        allow_any_instance_of(RailsImporter::Base).to receive(:open_spreadsheet)
        expect_any_instance_of(RailsImporter::Base).to receive(:open_spreadsheet)
        base = RailsImporter::Base.new('some_invalid_filepath')
      end

      it "adds a hash with error details to messages" do
        base = RailsImporter::Base.new('some_invalid_filepath')
        expect(base.messages).not_to be_empty
      end
    end
  end


  describe ".key" do
    it "returns a keyname based on class name" do
      expect(subject.class.key).to eq 'base'
    end
  end

  describe "#load_data" do
    it "raises an exception because concrete importers must implement it" do
      expect { subject.load_data(row: '') }.to raise_exception(RuntimeError)
    end
  end

  describe "#process" do
    context "when filepath is valid" do
      it "processes each row of the spreadsheet" do
        allow(subject).to receive(:load_data)
        expect(subject).to receive(:load_data)
        subject.process
      end
    end

    context "when filepath is invalid" do
      it "processes nothing" do
        base = RailsImporter::Base.new('some_invalid_filepath')
        expect(base).not_to receive(:load_data)
        base.process
      end
    end
  end

  describe ".sample" do
    it "returns the sample file path of the importer" do
      expect(subject.class.sample_file).to eq Rails.root.join('lib/rails_importer/templates/base.xlsx')
    end
  end
end
