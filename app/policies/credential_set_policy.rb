# frozen_string_literal: true

class CredentialSetPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def show?
    can_read_exercise?
  end

  def create?
    false
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    next relation if user.super_admin?
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .distinct
  end
end
