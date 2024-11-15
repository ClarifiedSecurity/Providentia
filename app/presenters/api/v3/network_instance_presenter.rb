# frozen_string_literal: true

module API
  module V3
    class NetworkInstancePresenter < Struct.new(:network, :actor_number)
      def as_json
        {
          team_nr: actor_number,
          actor_nr: actor_number,
          cloud_id: substitute(network.cloud_id),
          domains: network.domain_bindings.full_names.map { substitute(it) },
          address_pools: network.address_pools.map do |pool|
            {
              id: pool.slug,
              ip_family: pool.ip_family,
              network_address: substitute(pool.network_address),
              gateway: pool.gateway_address_object&.ip_object(actor_number:)&.to_s
            }
          end,
          config_map: network.config_map&.deep_transform_values do |value|
            value.is_a?(String) ? substitute(value) : value
          end
        }
      end

        private
          def substitute(text)
            StringSubstituter.result_for(text, { actor_nr: actor_number })
          end
    end
  end
end
