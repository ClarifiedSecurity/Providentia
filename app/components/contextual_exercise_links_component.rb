# frozen_string_literal: true

class ContextualExerciseLinksComponent < ContextualLinksComponent
  include ApplicationHelper
  attr_reader :exercise

  def initialize(exercise: nil)
    @exercise = exercise
  end

  private
    def menu_items
      return super if !exercise.persisted?
      [Network, VirtualMachine, Service, Capability]
        .tap { _1 << CredentialSet if Rails.configuration.x.features.dig(:credentials) }
        .map { MenuItem.new(
            url: [exercise, _1.name.underscore.pluralize.to_sym],
            icon: _1.to_icon,
            content: ar_class_to_link_text(_1)
          )
        }
    end
end
