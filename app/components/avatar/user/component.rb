# frozen_string_literal: true

class Avatar::User::Component < Avatar::Component
  param :user

  private
    def text = user.initials
    def color = :yellow
end
