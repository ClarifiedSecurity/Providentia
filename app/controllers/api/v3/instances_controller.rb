# frozen_string_literal: true

module API
  module V3
    class InstancesController < APIController
      before_action :get_exercise, :authorize_spec, :validate_id, :validate_params

      def update
        datum = spec.instance_metadata.first_or_create(instance: params[:id])
        if datum && datum.update(
          metadata: if request.patch?
                      datum.metadata.merge(metadata_param)
                    else
                      metadata_param
                    end
        )
          render json: { result: datum }
        else
          render_error(message: 'Saving metadata failed!')
        end
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end

      private
        def spec
          @spec ||= policy_scope(@exercise.customization_specs)
            .for_api
            .friendly.find(params[:customization_spec_id])
        end

        def authorize_spec
          authorize(spec, :update?)
        end

        def validate_id
          return if valid_instance_ids.include?(params[:id])
          render_not_found
        end

        def valid_instance_ids
          CustomizationSpecPresenter.new(spec).as_json[:instances].map { _1[:id] }
        end

        def validate_params
          return if params[:metadata].is_a? ActionController::Parameters
          render_error(status: 400, message: 'Metadata must be a dictionary!')
        end

        def metadata_param
          params.require(:metadata).permit!
        end
    end
  end
end
