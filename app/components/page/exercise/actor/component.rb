# frozen_string_literal: true

class Page::Exercise::Actor::Component < ApplicationViewComponent
  include ActorColorsMixin

  param :actor
  param :tree
end
