# frozen_string_literal: true

class HoverGroup::Component < ApplicationViewComponent
  renders_many :buttons, HoverGroup::Button::Component
end
