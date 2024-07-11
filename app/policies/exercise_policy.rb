# frozen_string_literal: true

class ExercisePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.role_bindings.for_user(user).exists?
  end

  def create?
    user.resources.include?(UserPermissions::ENVIRONMENT_CREATION)
  end

  def edit?
    update?
  end

  def update?
    (create? && !record.persisted?) || has_env_role?('environment_admin')
  end

  def list_archived?
    false
  end

  def clone?
    update?
  end

  def archive?
    update?
  end

  relation_scope do |relation, opts = {}|
    if user.super_admin?
      if opts[:with_archived]
        relation
      else
        relation.active
      end
    else
      relation.for_user(user).active.distinct
    end
  end

  private
    def exercise
      record
    end
end
