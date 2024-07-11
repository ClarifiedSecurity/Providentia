# frozen_string_literal: true

class ServicePolicy < ApplicationPolicy
  pre_check :deny_read_only_updates!, only: %i[create? update? destroy?]

  include EnvironmentAssociatedPolicy

  def index?
    show?
  end

  def show?
    can_read_exercise?
  end

  def create?
    has_env_role? %w(environment_service_dev)
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
      .joins(:exercise)
      .merge(Exercise.for_user(user))
      .distinct
  end

  private
    def deny_read_only_updates!
      deny! if exercise.services_read_only
    end
end
