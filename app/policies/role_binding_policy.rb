# frozen_string_literal: true

class RoleBindingPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy
  skip_pre_check :allow_exercise_admins!, only: :destroy?

  def create?
    false
  end

  def destroy?
    has_env_role?('environment_admin') && not_last_access?
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

  private
    def not_last_access?
      exercise.role_bindings.role_environment_admin.where.not(user_email: user.email).exists?
    end
end
