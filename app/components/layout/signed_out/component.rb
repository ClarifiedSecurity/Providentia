# frozen_string_literal: true

class Layout::SignedOut::Component < ApplicationViewComponent
  private
    def render? = !helpers.user_signed_in?
end
