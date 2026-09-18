# frozen_string_literal: true

class Layout::SignedIn::Component < ApplicationViewComponent
  private
    def render? = helpers.user_signed_in?

    def contextual_component
      case { controller_name:, action_name: }
      # in controller_name: 'exercises'
      #   ContextualExerciseLinks::Component.new(exercise: @exercise)
      in controller_name: 'virtual_machines', action_name: 'index'
        ContextualInventory::Component.new
      else
      end
    end
end
