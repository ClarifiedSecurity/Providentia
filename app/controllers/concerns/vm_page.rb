# frozen_string_literal: true

module VmPage
  extend ActiveSupport::Concern

  private
    def preload_form_collections
      @system_owners = authorized_scope(User.all).join_role_bindings.where(role_bindings: { exercise_id: @exercise.id }).order(:name).load_async
      @capabilities = authorized_scope(@exercise.capabilities).order(:name).load_async
      @actors = authorized_scope(@exercise.actors, as: :vm_dev).or(Actor.where(id: @virtual_machine&.actor_id)).distinct
    end

    def preload_services
      @services = Hash.new { [] }

      @virtual_machine.customization_specs.reduce(@services) do |acc, spec|
        acc[spec.id] = authorized_scope(@exercise.services).for_spec(spec)
        acc
      end
    end
end
