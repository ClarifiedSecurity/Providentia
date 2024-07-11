# frozen_string_literal: true

module EnvironmentAssociatedPolicy
  extend ActiveSupport::Concern

  included do
    pre_check :allow_exercise_admins!
  end

  private
    def allow_exercise_admins!
      allow! if has_env_role? 'environment_admin'
    end

    def can_read_exercise?
      allowed_to?(:show?, exercise)
    end

end
