# frozen_string_literal: true

class RoleBindingPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def create?
    false
  end

  def destroy?
    false
  end

  relation_scope do |relation|
    next relation if user.super_admin?

    relation
      .joins(:exercise)
      .where(
        exercise_id: RoleBinding.for_user(user)
          .where(role: :environment_admin).pluck(:exercise_id)
      )
  end
end
