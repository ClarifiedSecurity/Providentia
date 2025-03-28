# frozen_string_literal: true

module API
  module V3
    class CustomizationSpecsController < APIController
      before_action :get_exercise

      def index
        render json: {
          result: authorized_scope(@exercise.customization_specs).pluck(:slug).sort
        }
      end

      def show
        render json: {
          result: CustomizationSpecPresenter.new(
            spec,
            include_metadata: true,
            include_custom_tags: allowed_to?(:read_tags?, spec)
          )
        }
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end

      private
        def spec
          @spec ||= authorized_scope(@exercise.customization_specs)
            .for_api
            .friendly.find(params[:id])
        end
    end
  end
end
