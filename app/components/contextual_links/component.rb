# frozen_string_literal: true

class ContextualLinks::Component < ApplicationViewComponent
  MenuItem = Data.define(:url, :content, :icon)

  private
    def render?
      menu_items.any?
    end

    def menu_items
      []
    end
end
