Rails.application.routes.draw do

  mount RailsImporter::Engine => "/"

  root controller: 'imports', action: 'new'
end
