# frozen_string_literal: true

class ActorAvatar::Component < ApplicationViewComponent
  def initialize(actor:)
    @actor = actor
  end

  private
    def attributes
      {
        class: helpers.actor_color_classes(@actor),
        data: { action: 'mouseenter->tooltip#show mouseleave->tooltip#hide' }
      }
    end
end
