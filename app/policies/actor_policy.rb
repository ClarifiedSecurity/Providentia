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
    actor_dev = Actor.arel_table[:id].eq(RoleBinding.arel_table[:actor_id]).and(
      RoleBinding.arel_table[:role].eq(:actor_dev)
    )
    is_env_role = Actor.arel_table[:exercise_id].eq(RoleBinding.arel_table[:exercise_id])
    actor_admin = is_env_role.and(RoleBinding.arel_table[:role].in([:environment_admin]))
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .where(
        actor_dev
        .or(actor_admin)
      )
  end
end
