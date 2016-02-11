FactoryGirl.define do
  factory :import do
    importer_key "importer"
    import_file { 
      ActionDispatch::Http::UploadedFile.new({ filename: 'importer.xlsx',
      tempfile: File.new("lib/rails_importer/templates/importer.xlsx")
    })}
  end

  factory :invalid_import, class: Import do
  end
end
