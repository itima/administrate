require_relative "associative"

module Administrate
  module Field
    class BelongsTo < Associative
      def self.permitted_attribute(attr)
        :"#{attr}_id"
      end
  
      def permitted_attribute
        self.class.permitted_attribute(attribute)
      end
  
      def associated_resource_options
        resources = candidate_resources.map do |resource|
          [display_candidate_resource(resource), resource.id]
        end
        if options.fetch(:allow_nil, true)
          resources = [nil] + resources
        else
          resources
        end
      end
  
      def selected_option
        data && data.id
      end
  
      private
  
      def candidate_resources
        associated_class.all
      end
  
      def display_candidate_resource(resource)
        associated_dashboard.display_resource(resource)
      rescue StandardError
        resource.to_s
        #"#{resource.to_s} [id:#{resource.id}]"
      end
    end
  end
end
