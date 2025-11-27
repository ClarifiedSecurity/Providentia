# frozen_string_literal: true

class Avatar::Component < ApplicationViewComponent
  def initialize(user:)
    @user = user
  end
end
