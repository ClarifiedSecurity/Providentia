# frozen_string_literal: true

class AddAccessForm < Patterns::Form
  include ActionPolicy::Behaviour
  authorize :user, through: :form_owner

  param_key 'access'

  attribute :assignment_mode, String
  attribute :assignment_target, String
  attribute :actor_id, Integer
  attribute :role, String

  validates :assignment_mode, :role, :assignment_target, presence: true
  validates :role, inclusion: { in: RoleBinding.roles.keys, allow_nil: true }
  validates :actor_id, presence: true, if: :is_actor_role?
  validate :can_read_actor?, if: :is_actor_role?

  private
    def persist
      process_attributes_by_mode
      resource.role = role
      resource.actor_id = actor_id if is_actor_role?
      resource.save
    end

    def process_attributes_by_mode
      case assignment_mode
      when 'email'
        resource.user_email = assignment_target
      when 'resource'
        resource.user_resource = assignment_target
      else
        errors.add(:assignment_mode, :invalid)
      end
    end

    def is_actor_role?
      role.start_with?('actor_')
    end

    def can_read_actor?
      allowed_to?(:show?, actor)
    end

    def actor
      return @actor if defined?(@actor)
      @actor = authorized_scope(Actor.all).find_by(id: actor_id)
    end
end
