# frozen_string_literal: true

class NetworkMap::Component < ApplicationViewComponent
  attr_reader :exercise

  def initialize(exercise:)
    @exercise = exercise
  end

  private
    def data_tags
      {
        controller: 'map',
        graph_endpoint: controller.exercise_map_path(format: :json)
      }
    end
end
