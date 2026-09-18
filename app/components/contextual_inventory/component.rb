# frozen_string_literal: true

class ContextualInventory::Component < ApplicationViewComponent
  private
    def filter_actor = controller_var :filter_actor
end
