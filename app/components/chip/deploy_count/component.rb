# frozen_string_literal: true

class Chip::DeployCount::Component < Chip::Component
  param :host
  param :network

  private
    def render? = numbered_by_sequential? || network_not_numbered_and_actor_is_numbered?
    def numbered_by_sequential? = host.custom_instance_count.to_i > 1
    def network_not_numbered_and_actor_is_numbered? = !network.numbered? && host.team_numbers

    def title = numbered_by_sequential? ? 'Custom instance count' : I18n.t(
      'deploy_modes.per_item',
      item: host.numbered_actor.name
    )
    def value = "+#{(numbered_by_sequential? ? host.custom_instance_count - 1 : host.team_numbers.size - 1)}"
    def flavor = numbered_by_sequential? ? :emerald : :violet
end
