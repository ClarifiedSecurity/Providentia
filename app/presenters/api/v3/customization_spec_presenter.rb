# frozen_string_literal: true

module API
  module V3
    class CustomizationSpecPresenter
      attr_reader :spec, :options

      def initialize(spec, **opts)
        @spec = spec
        @options = opts
      end

      def as_json(_opts = nil)
        Rails.cache.fetch(cache_key) do
          preload_interfaces
          {
            id: spec.slug,
            spec_name: spec.name.to_url,
            customization_context: spec.mode,
            owner: (spec.user || vm.system_owner)&.name,
            description: spec.mode_host? ? vm.description : spec.description,
            role: spec.role,
            actor_id: vm.actor.abbreviation,
            actor_name: vm.actor.name,
            visibility: vm.visibility,
            hardware_cpu: vm.cpu || vm.operating_system&.applied_cpu,
            hardware_ram: vm.ram || vm.operating_system&.applied_ram,
            hardware_primary_disk_size: vm.primary_disk_size || vm.operating_system&.applied_primary_disk_size,
            egress_networks: Current.interfaces_cache[vm.id].filter_map do |nic|
              nic.network.slug if nic.egress?
            end,
            connection_network: Current.interfaces_cache[vm.id]
              .detect(&:connection?)
              &.network
              &.slug,
            tags:,
            capabilities:,
            services:,
            instances:
          }
          .merge(sequence_info)
        end
      end

      private
        def cache_key
          [
            'apiv3',
            vm.exercise.cache_key_with_version,
            vm.operating_system&.path&.cache_key_with_version,
            vm.cache_key_with_version,
            spec.cache_key_with_version,
            vm.actor&.cache_key_with_version,
            vm.actor&.root&.cache_key_with_version,
            'numbering',
            vm.numbered_actor&.cache_key_with_version,
            vm.numbered_actor&.root&.cache_key_with_version,
            options[:include_metadata] ? 'metadata' : nil,
            options[:include_metadata] ? spec.instance_metadata.cache_key_with_version : nil
          ].compact
        end

        def vm
          spec.virtual_machine
        end

        def host_spec
          vm.host_spec.tap { |spec| spec.virtual_machine = vm } # set manually to avoid extra db call
        end

        def preload_interfaces
          Current.interfaces_cache ||= {}
          Current.interfaces_cache[vm.id] ||= vm.network_interfaces.for_api.load_async
        end

        def tags
          GenerateTags.result_for(self).map(&:id)
        end

        def services
          Service.for_spec(spec).pluck(:slug)
        end

        def instances
          spec.deployable_instances(InstancePresenter, **options).filter_map(&:as_json)
        end

        def capabilities
          spec.capabilities.pluck(:slug).to_a
        end

        def sequence_info
          if vm.clustered? && spec.cluster_mode?
            {
              sequence_tag: spec.slug.tr('-', '_'),
              sequence_total: vm.custom_instance_count
            }
          else
            {
              sequence_tag: nil,
              sequence_total: nil
            }
          end
        end
    end
  end
end
