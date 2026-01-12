# frozen_string_literal: true

module API
  module V3
    class NetworkPresenter < Struct.new(:network)
      def as_json(_opts = nil)
        Rails.cache.fetch(['apiv3', network.actor.cache_key_with_version, network.cache_key_with_version]) do
          {
            id: network.slug,
            name: network.name,
            description: network.description,
            actor: network.actor.abbreviation.downcase,
            instances:
          }
        end
      end

      private
        def instances
          NetworkInstances.result_for(network).map do |instance_nr|
            NetworkInstancePresenter.new(network, instance_nr).as_json
          end
        end
    end
  end
end
