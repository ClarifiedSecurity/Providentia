# frozen_string_literal: true

class APITokenPolicy < ApplicationPolicy
  def destroy?
    record.user_id == user.id
  end

  relation_scope do |relation|
    relation.where(user:)
  end
end
