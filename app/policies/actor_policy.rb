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
    developer_actors = Actor.where(
      id: RoleBinding.for_user(user).where(role: :actor_dev).pluck(:actor_id)
    ).flat_map(&:subtree_ids)

    is_env_role = Actor.arel_table[:exercise_id].eq(RoleBinding.arel_table[:exercise_id])
    actor_admin = is_env_role.and(RoleBinding.arel_table[:role].in([:environment_admin]))
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .where(
        Actor.arel_table[:id].in(developer_actors)
        .or(actor_admin)
      )
  end
end
