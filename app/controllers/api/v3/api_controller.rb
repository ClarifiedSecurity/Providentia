# frozen_string_literal: true

module API
  module V3
    class APIController < ActionController::API
      include ActionPolicy::Controller
      authorize :user, through: :current_user

      attr_reader :current_user

      before_action :set_sentry_context, :authenticate_request
      rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized

      private
        def set_sentry_context
          Sentry.set_user(id: current_user&.id)
          Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
        end

        def token_value
          request.headers['Authorization']&.sub(/(Token|Bearer) /, '')
        end

        def authenticate_request
          Current.user = @current_user = authenticate_by_local_token || authenticate_by_access_token
          render_error(status: 401, message: 'Unauthenticated') unless @current_user
        end

        def authenticate_by_local_token
          User.joins(:api_tokens).where(api_tokens: { token: token_value }).first
        end

        def authenticate_by_access_token
          APIVerifyService.call(token_value).result
        end

        def get_exercise
          @exercise = authorized_scope(Exercise.all).friendly.find(params[:exercise_id])
        rescue ActiveRecord::RecordNotFound
          render_not_found
        end

        def render_error(status: 400, message:)
          render status:, json: {
            error: {
              code: status,
              message:
            }
          }
        end

        def user_not_authorized
          render_error(status: 403, message: 'You are not authorized to perform this action.')
        end

        def render_not_found
          render_error(status: 404, message: 'Not found')
        end
    end
  end
end
