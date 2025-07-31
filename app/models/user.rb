# frozen_string_literal: true

class User < ApplicationRecord
  has_many :owned_systems, class_name: 'VirtualMachine', foreign_key: :system_owner_id
  has_many :customization_specs
  has_many :virtual_machines, through: :customization_specs
  has_many :api_tokens

  devise :trackable, :omniauthable, omniauth_providers: %i[sso]

  scope :join_role_bindings, ->() {
    joins('inner join role_bindings on users.resources ? role_bindings.user_resource or users.email = role_bindings.user_email')
  }
  scope :in_exercise, ->(exercise) {
    join_role_bindings.where(role_bindings: { exercise_id: exercise })
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

  def accessible_exercises
    permissions.except('admin').tap do |hash|
      hash.default = []
    end
  end

  def super_admin?
    resources.include?(UserPermissions::SUPERADMIN_ACCESS)
  end
end
