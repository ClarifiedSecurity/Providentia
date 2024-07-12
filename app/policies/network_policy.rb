# frozen_string_literal: true

class NetworkPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def index?
    can_read_exercise?
  end

  def create?
    has_env_role? %w(environment_net_dev)
  end

  def show?
    accessible_through_actor_role? ||
      read_access_through_env_role? ||
      can_read_exercise? && record.visibility_public?
  end

  def edit?
    update?
  end

  def update?
    create?
  end

  def destroy?
    update?
  end

  relation_scope do |relation|
    next relation if user.super_admin?
    public_net = Network.arel_table[:visibility].eq(:public)
    in_same_env = Network.arel_table[:exercise_id].eq(RoleBinding.arel_table[:exercise_id])
    env_role = in_same_env.and(RoleBinding.arel_table[:role].in([:environment_admin, :environment_net_dev, :environment_service_dev]))
    actor_role = Network.arel_table[:actor_id].in(RoleBinding.for_user(user).pluck(:actor_id).compact)
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .where(
        public_net
        .or(actor_role)
        .or(env_role)
      )
      .distinct
  end

  private
    def read_access_through_env_role?
      has_env_role? %w(environment_net_dev environment_service_dev)
    end
end
