# frozen_string_literal: true

class Avatar::Actor::Component < Avatar::Component
  param :actor

  private
    def text = actor.initials
    def color = actor.ui_color.to_sym
end
