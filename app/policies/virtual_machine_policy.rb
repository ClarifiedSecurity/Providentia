# frozen_string_literal: true

class VirtualMachinePolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def index?
    can_read_exercise?
  end

  def create?
    RoleBinding
      .for_user(user)
      .where(exercise:, role: :actor_dev)
      .exists?
  end

  def show?
    accessible_through_actor_role? ||
      has_env_roles? ||
      can_read_exercise? && record.visibility_public?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    next relation if user.super_admin?
    public_vm = VirtualMachine.arel_table[:visibility].eq(:public)
    in_same_env = VirtualMachine.arel_table[:exercise_id].eq(RoleBinding.arel_table[:exercise_id])
    env_role = in_same_env.and(RoleBinding.arel_table[:role].in([:environment_admin, :environment_service_dev]))
    actor_role = VirtualMachine.arel_table[:actor_id].in(RoleBinding.for_user(user).map(&:actor).compact.flat_map(&:subtree_ids).uniq)
    relation
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .where(
        public_vm
        .or(actor_role)
        .or(env_role)
      )
      .distinct
  end

  private
    def has_env_roles?
      has_env_role? %w(environment_service_dev)
    end
end
