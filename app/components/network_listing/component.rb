# frozen_string_literal: true

class NetworkListing::Component < ApplicationViewComponent
  param :networks

  option :context_actor, optional: true, model: Actor

  private
    def show_actor_column? = context_actor && networks.map(&:actor).uniq != [context_actor]
end
