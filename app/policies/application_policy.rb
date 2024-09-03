# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  pre_check :allow_super_admins!

  private
    def allow_super_admins!
      allow! if user.super_admin?
    end

    def exercise
      record.exercise
    end

    def environment_roles
      @environment_roles ||= Set.new(exercise.role_bindings.for_user(user).pluck(:role))
    end

    def has_env_role?(lookup)
      environment_roles.intersect? Set.new([lookup].flatten)
    end

    def actor_roles
      @actor_roles ||= Set.new(RoleBinding.for_user(user).where(exercise:, actor_id: record.actor&.root_id).pluck(:role))
    end

    def accessible_through_actor_role?
      actor_roles.any?
    end

    def modifiable_through_actor_role?
      actor_roles.include? 'actor_dev'
    end
end
