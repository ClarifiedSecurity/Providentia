# frozen_string_literal: true

class Util::IconGroup::Component < ApplicationViewComponent
  renders_many :buttons, Util::IconGroup::Button::Component
end
