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
        .preload(virtual_machine: [:numbered_by])
        .includes(:network, :address_pool)
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

    def network_options_for_select
      network_collection_scope
        .group_by { _1.actor }
        .map do |actor, networks|
          helpers.content_tag(
            :optgroup,
            helpers.options_for_select(
              networks.map { [_1.name, _1.id, { data: { terms: [_1.abbreviation, _1.cloud_id].compact } }] },
              network_interface.network_id
            ),
            label: actor.name
          )
        end.join.html_safe
    end
end
