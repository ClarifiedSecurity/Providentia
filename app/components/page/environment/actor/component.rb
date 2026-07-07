# frozen_string_literal: true

class Page::Environment::Actor::Component < ApplicationViewComponent
  include ActorColorsMixin

  param :actor
  param :tree
end
