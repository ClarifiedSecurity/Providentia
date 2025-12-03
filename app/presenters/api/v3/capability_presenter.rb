# frozen_string_literal: true

module API
  module V3
    class CapabilityPresenter < Struct.new(:capability)
      def as_json(_opts = nil)
        Rails.cache.fetch(['apiv3', capability.customization_specs.cache_key_with_version, capability.cache_key_with_version]) do
          {
            id: capability.slug,
            name: capability.name,
            description: capability.description,
            actors: capability.actors.map(&:abbreviation),
            hosts: capability.customization_specs.pluck(:slug)
          }
        end
      end
    end
  end
end
