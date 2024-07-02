# frozen_string_literal: true

class ActorPolicy < ApplicationPolicy
  def show?
    can_read_exercise?
  end

  def create?
    can_edit_exercise?
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
      .distinct
      .joins(:exercise)
      .merge(Exercise.for_user(user))
  end

  private
    def can_edit_exercise?
      allowed_to?(:update?, record.exercise)
    end

    def can_read_exercise?
      allowed_to?(:show?, record.exercise)
    end
end
