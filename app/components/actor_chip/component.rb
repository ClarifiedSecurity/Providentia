# frozen_string_literal: true

class ActorChip::Component < ApplicationViewComponent
  include ActorColorsMixin

  param :actor
  option :text, optional: true

  private
    def data
      if text != actor.name
        { controller: 'tooltip', action: 'mouseenter->tooltip#show mouseleave->tooltip#hide', tooltip: actor.name }
      end
    end
end
