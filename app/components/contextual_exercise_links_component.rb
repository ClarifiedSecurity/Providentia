# frozen_string_literal: true

class ContextualExerciseLinksComponent < ContextualLinksComponent
  attr_reader :exercise

  def initialize(exercise: nil)
    @exercise = exercise
  end

  private
    def menu_items
      return super if !exercise
      [Network, VirtualMachine, Service, Capability]
        .tap { _1 << CredentialSet if Rails.configuration.x.features.dig(:credentials) }
        .map { MenuItem.new(url: [exercise, _1.name.underscore.pluralize.to_sym], content: helpers.ar_class_to_link_text(_1)) }
    end
end
