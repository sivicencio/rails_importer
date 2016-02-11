Rails.application.routes.draw do

  mount RailsImporter::Engine => "/rails_importer"
end
