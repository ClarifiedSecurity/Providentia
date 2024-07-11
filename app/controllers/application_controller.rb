# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_sentry_context, :authenticate_user!,
    :set_paper_trail_whodunnit
  before_action :load_exercises, if: :current_user

  rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_authorized

  private
    def load_exercises
      @exercises = authorized_scope(Exercise.all).active.order(:name)
    end

    def set_sentry_context
      Sentry.set_user(id: current_user&.id)
      Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
    end

    def get_exercise
      @exercise = authorized_scope(Exercise.all).friendly.find(params[:exercise_id])
    end

    def user_not_authorized
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_back fallback_location: root_path
    end
end
