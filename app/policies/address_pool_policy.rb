# frozen_string_literal: true

class AddressPoolPolicy < ApplicationPolicy
  def create?
    allowed_to?(:update?, record.network)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    next relation if user.super_admin?
    relation.none
  end
end
