# frozen_string_literal: true

class RoleBinding < ApplicationRecord
  belongs_to :exercise
  belongs_to :actor, optional: true

  enum :role, {
    environment_member: 1,
    environment_net_dev: 2,
    environment_service_dev: 3,
    environment_admin: 4,
    actor_readonly: 5,
    actor_dev: 6
  }, prefix: :role

  scope :for_user, ->(user) {
    where(user_email: user.email)
      .or(where(user_resource: user.resources))
  }

  scope :for_environment, ->(environment) {
    where(actor_id: environment.actor_ids).
      or(where(exercise: environment))
  }
end
