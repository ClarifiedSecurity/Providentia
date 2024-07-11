# frozen_string_literal: true

module API
  module V3
    class ExercisesController < APIController
      def index
        render json: {
          result: authorized_scope(Exercise.all).map do |ex|
            {
              id: ex.slug,
              name: ex.name
            }
          end
        }
      end

      def show
        exercise = authorized_scope(Exercise.all).friendly.find(params[:id])

        render json: { result: ExercisePresenter.new(exercise) }
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end
    end
  end
end
