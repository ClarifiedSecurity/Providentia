# frozen_string_literal: true

class ContextualLinksComponent < ViewComponent::Base
  MenuItem = Data.define(:url, :content)

  private
    def render?
      menu_items.any?
    end

    def menu_items
      []
    end
end
