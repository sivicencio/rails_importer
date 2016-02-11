module RailsImporter
  class Engine < ::Rails::Engine
    isolate_namespace RailsImporter

    ActiveSupport.on_load(:action_controller) do
      include RailsImporter::Controllers::Helpers
    end
  end
end
