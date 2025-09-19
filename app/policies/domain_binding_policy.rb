# frozen_string_literal: true

class DomainBindingPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def show?
    can_read_exercise?
  end

  def create?
    has_env_role? %w(environment_net_dev)
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
      .joins(network: [:exercise])
      .merge(Exercise.for_user(user))
  end

  private
    def exercise
      record.network.exercise
    end
end
