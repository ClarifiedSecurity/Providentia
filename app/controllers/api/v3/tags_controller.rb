# frozen_string_literal: true

module API
  module V3
    class TagsController < APIController
      before_action :get_exercise

      def index
        render json: { result: TagsPresenter.new(@exercise, spec_scope, vm_scope) }
      end

      private
        def spec_scope
          @spec_scope ||= authorized_scope(@exercise.customization_specs)
        end

        def vm_scope
          @vm_scope ||= authorized_scope(@exercise.virtual_machines)
        end
    end
  end
end
