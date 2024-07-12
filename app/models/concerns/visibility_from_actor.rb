# frozen_string_literal: true

module VisibilityFromActor
  extend ActiveSupport::Concern

  included do
    before_create :set_visibility_from_actor
  end

  private
    def set_visibility_from_actor
      self.visibility = actor.default_visibility if actor
    end
end
