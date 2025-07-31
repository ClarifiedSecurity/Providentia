# frozen_string_literal: true

class ContextualInventoryComponent < ViewComponent::Base
  attr_reader :exercise, :filter_actor

  def initialize(exercise:, filter_actor:)
    @exercise = exercise
    @filter_actor = filter_actor
  end
end
