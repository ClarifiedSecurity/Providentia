# frozen_string_literal: true

class Chip::Component < ApplicationViewComponent
  include ActorColorsMixin

  with_collection_parameter :text

  option :text, optional: true
  option :icon, optional: true, default: nil
  option :flavor, optional: true, default: -> { :stone }

  private
    def title = value
    def value = text
end
