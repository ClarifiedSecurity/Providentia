# frozen_string_literal: true

class ExercisePolicy < ApplicationPolicy
  pre_check :allow_exercise_admins, except: [:create?, :list_archived?]

  def index?
    true
  end

  def show?
    record.role_bindings.for_user(user).exists?
  end

  def create?
    user.super_admin?
  end

  def update?
    false
  end

  def list_archived?
    user.super_admin?
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
    def allow_exercise_admins
      allow! if exercise_admin?(exercise: record)
    end
end
