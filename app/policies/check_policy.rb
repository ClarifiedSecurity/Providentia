# frozen_string_literal: true

class CheckPolicy < ApplicationPolicy
  def create?
    allowed_to?(:update?, record.service)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    next relation
  end
end
