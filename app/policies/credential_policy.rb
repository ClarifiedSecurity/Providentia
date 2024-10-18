# frozen_string_literal: true

class CredentialPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    allowed_to?(:update?, record.credential_set)
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
