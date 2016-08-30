module RailsImporter
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      def after_import_path
        context.root_path
      end

      protected

      def context
        router_name = RailsImporter.router_name
        context = router_name ? send(router_name) : self
      end
    end
  end
end
