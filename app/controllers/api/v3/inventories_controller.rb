# frozen_string_literal: true

module API
  module V3
    class InventoriesController < APIController
      before_action :get_exercise

      def show
        scope = authorized_scope(@exercise.customization_specs).for_api
        render json: {
          result: scope.map {
            CustomizationSpecPresenter.new(
              it,
              include_metadata: false,
              include_custom_tags: allowed_to?(:read_tags?, it)
            )
          }
        }
      end
    end
  end
end
