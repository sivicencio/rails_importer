require "rails_helper"

describe RailsImporter::ImportsController, type: :controller do
  routes { RailsImporter::Engine.routes }

  let(:import) { FactoryGirl.build(:import, importer_key: 'example') }

  describe "GET new" do
    before(:each) { get :new, importer_key: 'example' }

    it { expect(response).to be_success }
    it { expect(response).to render_template("new") }

    it "assigns a new import as @import" do
      expect(assigns(:import)).to be_an(Import)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      context "import matters" do
        it "performs the import task" do
          allow(ImportJob).to receive(:perform_later).with(import.importer_key, import.filepath)
          expect(ImportJob).to receive(:perform_later).with(import.importer_key, import.filepath)
          post :create, importer_key: 'example', import: FactoryGirl.attributes_for(:import, importer_key: 'example')
        end
      end
      
      context "happy path matters" do
        before(:each) do
          allow(ImportJob).to receive(:perform_later).with(import.importer_key, import.filepath)
          post :create, importer_key: 'example', import: FactoryGirl.attributes_for(:import, importer_key: 'example')
        end

        it { expect(response.status).to eq(302) }

        it { expect(assigns(:import)).to be_an(Import) }

        it { expect(response).to redirect_to('/') }

        it "has no error messages" do
          expect(flash[:error]).to be_nil
        end
        it "has a success message" do
          expect(flash[:notice]).to_not be_nil
        end
      end      
    end

    describe "with invalid params" do
      before(:each) { post :create, importer_key: 'example', import: FactoryGirl.attributes_for(:invalid_import) }

      it "assigns a newly created import as @import" do
        expect(assigns(:import)).to be_an(Import)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end

      it "has no success messages" do
        expect(flash[:notice]).to be_nil
      end
    end
  end
end
