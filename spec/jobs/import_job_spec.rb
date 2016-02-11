require 'rails_helper'

RSpec.describe ImportJob, type: :job do
  after do
    clear_enqueued_jobs
  end

  it "performs the processing of an importer file" do
    import = FactoryGirl.build(:import, importer_key: 'example')
    allow_any_instance_of(RailsImporter::Base).to receive(:process)
    expect_any_instance_of(RailsImporter::Base).to receive(:process)
    subject.class.perform_now(import.importer_key, import.filepath)
  end
end
