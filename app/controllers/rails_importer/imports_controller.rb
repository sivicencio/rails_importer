module RailsImporter
  class ImportsController < ::ApplicationController
    before_filter :set_importer_class

    def new
      @import = Import.new(importer_key: @importer_class.key)
    end

    def create
      @import = Import.new(import_params)
      if @import.valid?
        ImportJob.perform_later @import.importer_key, @import.filepath
        flash[:notice] = I18n.t(:processing_import, scope: :rails_importer)
        redirect_to after_import_path
      else
        render 'new'
      end
    end

    def sample
      file = File.open(@importer_class.sample_file)

      send_data file.read, :filename => File.basename(@importer_class.sample_file)
    rescue => e
      flash[:alert] = I18n.t(:sample_file_not_available, scope: :rails_importer)
      redirect_to after_import_path
    end

    private

    def set_importer_class
      @importer_class = RailsImporter.importer_class(params[:importer_key].to_s)
      if @importer_class.nil?
        flash[:error] = I18n.t(:importer_does_not_exist, scope: :rails_importer)
        redirect_to after_import_path
      end
    end

    def import_params
      params.require(:import).permit(:importer_key, :import_file)
    end
  end
end
