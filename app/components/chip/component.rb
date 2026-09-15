# frozen_string_literal: true

class Chip::Component < ApplicationViewComponent
  include ActorColorsMixin

  with_collection_parameter :name

  option :name
  option :icon, optional: true, default: nil
  option :flavor, optional: true, default: -> { :stone }
end
