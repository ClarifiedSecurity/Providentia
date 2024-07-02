# frozen_string_literal: true

class RoleBindingPolicy < ApplicationPolicy
  def create?
    can_edit_exercise?
  end

  def destroy?
    can_edit_exercise?
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
    def can_edit_exercise?
      allowed_to?(:update?, record.exercise)
    end
end
