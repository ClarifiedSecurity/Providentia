# frozen_string_literal: true

class Avatar::Component < ApplicationViewComponent
  include ActorColorsMixin

  private
    def tooltip
    end

    def data_attributes
      return {} if !tooltip
      {
        controller: 'tooltip',
        action: 'mouseenter->tooltip#show mouseleave->tooltip#hide',
        tooltip:
      }
    end
end
