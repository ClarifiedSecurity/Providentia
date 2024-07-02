# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  pre_check :allow_admins

  private
    def allow_admins
      allow! if user.super_admin?
    end

    def owner?
      record.user_id == user.id
    end

    def exercise_admin?(exercise: record.exercise)
      exercise.role_bindings.for_user(user).role_environment_admin.exists?
    end
end
