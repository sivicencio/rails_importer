RailsImporter::Engine.routes.draw do
  scope "importers/:importer_key" do
    resources :imports, only: [:new, :create], path: ''
  end
end
