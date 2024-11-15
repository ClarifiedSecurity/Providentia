# frozen_string_literal: true

module API
  module V3
    class CredentialSetsController < APIController
      before_action :get_exercise

      def index
        render json: {
          result: scope.map { CredentialSetPresenter.new(_1) }
        }
      end

      private
        def scope
          authorized_scope(@exercise.credential_sets)
        end
    end
  end
end
