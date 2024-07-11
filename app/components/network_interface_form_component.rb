# frozen_string_literal: true

class NetworkInterfaceFormComponent < ViewComponent::Base
  with_collection_parameter :network_interface

  attr_reader :network_interface, :network_interface_counter, :disabled

  def initialize(network_interface:, network_interface_counter:, disabled: false)
    @network_interface = network_interface
    @network_interface_counter = network_interface_counter
    @disabled = disabled
  end

  private
    def collection
      helpers.authorized_scope(network_interface.exercise.networks).for_grouped_select
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
