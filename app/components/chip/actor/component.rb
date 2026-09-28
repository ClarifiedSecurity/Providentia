# frozen_string_literal: true

class Chip::Actor::Component < ApplicationViewComponent
  include ActorColorsMixin

  param :actor
  option :text, optional: true

  private
    def data
      if text && text != actor.name
        { controller: 'tooltip', action: 'mouseenter->tooltip#show mouseleave->tooltip#hide', tooltip: actor.name }
      end
    end
end
