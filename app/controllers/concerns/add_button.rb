# frozen_string_literal: true

module AddButton
  extend ActiveSupport::Concern

  AddAction = Data.define(:url)

  included do
    before_action :generate_add_action
  end

  private
    def generate_add_action
      if allowed_to?(:create?, model_class.new(exercise: @exercise)) && !action_name.in?(%w[new create])
        @add_action = AddAction.new(
          url: url_for([:new, @exercise, controller_name.singularize.to_sym])
        )
      end
    end

    def model_class
      @model_class ||= controller_name.classify.constantize
    end
end
