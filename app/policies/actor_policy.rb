# frozen_string_literal: true

class ActorPolicy < ApplicationPolicy
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
      .distinct
      .joins(:exercise)
      .merge(Exercise.for_user(user))
  end

  relation_scope(:vm_dev) do |relation|
    next relation if user.super_admin?
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .where(Actor.arel_table[:id].eq(RoleBinding.arel_table[:actor_id]))
      .where(role_bindings: { role: :actor_dev })
  end

end
