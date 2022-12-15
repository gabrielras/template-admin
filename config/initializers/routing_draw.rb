# frozen_string_literal: true

# Adds draw method into Rails routing
# It allows us to keep routing splitted into files
module ActionDispatch
  module Routing
    class Mapper
      def draw(routes_name)
        routes_name = routes_name.join('/') if routes_name.is_a?(Array)
        instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
      end
    end
  end
end
