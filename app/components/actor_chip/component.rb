# frozen_string_literal: true

class ActorChip::Component < ApplicationViewComponent
  include ActorColorsMixin

  def initialize(actor:, text: nil)
    @actor = actor
    @text = text
  end
end
