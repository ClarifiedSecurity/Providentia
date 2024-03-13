# frozen_string_literal: true

module VmPage
  extend ActiveSupport::Concern

  private
    def preload_form_collections
      @system_owners = policy_scope(User).order(:name).load_async
      @capabilities = policy_scope(@exercise.capabilities).order(:name).load_async
      @actors = policy_scope(@exercise.actors)
    end

    def preload_services
      @services = Hash.new { [] }

      @virtual_machine.customization_specs.reduce(@services) do |acc, spec|
        acc[spec.id] = policy_scope(@exercise.services).for_spec(spec)
        acc
      end
    end
end
