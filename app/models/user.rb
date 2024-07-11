# frozen_string_literal: true

class User < ApplicationRecord
  has_many :owned_systems, class_name: 'VirtualMachine', foreign_key: :system_owner_id
  has_many :api_tokens

  devise :trackable, :omniauthable, omniauth_providers: %i[sso]

  scope :admins, -> { where("permissions -> 'admin' = 'true'") }
  scope :for_exercise, ->(exercise) {
    admins.or(
      where('permissions ?| array[:keys]', keys: [exercise.id.to_s])
    )
  }

  def self.from_external(uid:, email:, resources:, extra_fields: {})
    resources = UserPermissions.result_for(resources || [])
    return unless resources

    (find_by(uid:) || find_by(email:) || create(uid:)).tap do |user|
      user.update({
        uid:,
        email: email || '',
        resources:
      }.merge(extra_fields))
    end
  end

  def initials
    name
      .split(' ', 2)
      .map(&:first)
      .join('')
      .upcase
  end

  def admin?
    permissions['admin']
  end

  def accessible_exercises
    permissions.except('admin').tap do |hash|
      hash.default = []
    end
  end

  def super_admin?
    resources.include?(UserPermissions::SUPERADMIN_ACCESS)
  end
end
