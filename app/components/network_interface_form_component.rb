# frozen_string_literal: true

class NetworkInterfaceFormComponent < ViewComponent::Base
  with_collection_parameter :network_interface

  attr_reader :network_interface, :disabled

  def initialize(network_interface:, disabled: false)
    @network_interface = network_interface
    @disabled = disabled
  end

  private
    def network_collection_scope
      @network_collection_scope ||= helpers
        .authorized_scope(network_interface.exercise.networks)
        .order(:name)
        .includes(:actor)
    end

    def network_collection
      network_collection_scope.group_by { |network| network.actor.name }
    end

    def addresses
      network_interface.addresses
        .order(:created_at)
        .includes(:network, :address_pool, :virtual_machine)
    end

    def team_classes
      helpers.actor_color_classes(network_interface.network&.actor)
    end

    def egress_toggle_text
      if network_interface.egress?
        'Remove egress'
      else
        'Mark egress'
      end
    end
end
