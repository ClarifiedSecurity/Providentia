# frozen_string_literal: true

class Avatar::Component < ApplicationViewComponent
  param :user

  option :tooltip, optional: true, default: false

  def tooltip_attributes
    return {} if !tooltip
    { data: { controller: 'tooltip', action: 'mouseenter->tooltip#show mouseleave->tooltip#hide', tooltip: user.name } }
  end
end
