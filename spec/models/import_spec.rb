require 'rails_helper'

describe Import, type: :model do

  ###############
  # attributes #
  ##############
  it { expect(subject).to respond_to :importer_key }
  it { expect(subject).to respond_to :import_file }

  ###############
  # validations #
  ###############
  it 'has a valid factory' do
    expect(FactoryGirl.build(:import)).to be_valid
  end

  it 'has an invalid factory' do
    expect(build(:invalid_import)).not_to be_valid
  end

  ###########
  # methods #
  ###########
  describe "#filepath" do
    it "returns a non empty filepath" do      
      expect(FactoryGirl.build(:import).filepath).not_to be_nil
    end
  end
end
