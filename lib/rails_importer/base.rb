require 'roo'

module RailsImporter
  class Base
    attr_reader :messages

    def initialize filepath, options={}
      if File.exists?(filepath)
        @filepath = filepath
      end

      @spreadsheet = nil

      @messages = []

      @rows = 0

      begin
        open_spreadsheet

        @rows = @spreadsheet.last_row
      rescue => e
        add_error message: e.message, backtrace: e.backtrace, row_index: nil, data: {}
      end

      # Custom behavior
    end

    # A unique key identifier for importer
    def self.key
      self.to_s.gsub('Importer', '').demodulize.underscore
    end

    # Load a file and the get data from each file row
    def process
      # Load each row element
      2.upto(@rows).each do |row_index|
        ActiveRecord::Base.transaction do
          begin
            load_data row: @spreadsheet.row(row_index)

          rescue => e
            add_error message: e.message, backtrace: e.backtrace, row_index: row_index, data: @spreadsheet.row(row_index)

            raise ActiveRecord::Rollback
          end
        end
      end
    end

    # Load a file and the get data from each file row
    #
    # @params
    #   row   => A row to be processed
    def load_data(row:)
      raise "#{__FILE__}:#{__LINE__} You must define it"
    end

    private

    # Returns a Roo instance acording the file extension.
    def open_spreadsheet sheet_name = ''
      extension = File.extname(@filepath.split("/").last)
      @spreadsheet = Roo::Spreadsheet.open(@filepath, extension: extension)
      @spreadsheet.default_sheet = @spreadsheet.sheets.include?(sheet_name) ? sheet_name : @spreadsheet.sheets.first
    rescue => e
      add_error message: e.message, backtrace: e.backtrace, row_index: nil, data: {}
    end

    # Add errors to import
    #
    # @params
    #   message   => Error message
    #   backtrace => Error Bactrace
    #   row_index => Failed row index
    #   data      => Readed data
    def add_error(message:, backtrace:, row_index:, data:)
      @messages << {message: message, backtrace: backtrace, row_index: row_index, data: data}
    end
  end
end
