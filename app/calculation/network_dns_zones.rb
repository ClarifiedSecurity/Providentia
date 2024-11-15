# frozen_string_literal: true

class NetworkDNSZones < Patterns::Calculation
  include ActionPolicy::Behaviour
  authorize :user, through: -> { Current.user }

  private
    def result
      return {} if !allowed_to?(:show?, subject)
      Rails.cache.fetch(cache_key) do
        initial_zones_hash
          .merge(forward_spec_records) { |_, old, new| old + new }
          .merge(reverse_spec_records)
      end
    end

    def spec_records
      @spec_records ||= specs.flat_map { SpecDNSRecords.result_for(it) }.select { it.network == subject }
    end

    def forward_spec_records
      spec_records
        .select { it.is_a?(SpecDNSRecords::ForwardRecord) && initial_zones_hash.key?(it.zone) }
        .group_by(&:zone)
        .transform_values { it.map(&:record) }
    end

    def reverse_spec_records
      spec_records
        .select { it.is_a?(SpecDNSRecords::ReverseRecord) }
        .group_by(&:zone)
        .transform_values { it.map(&:record) }
    end

    def cache_key
      [
        'dns_zones',
        subject.cache_key_with_version,
        authorized_scope(subject.actor.path).cache_key_with_version,
        authorized_scope(subject.virtual_machines).cache_key_with_version
      ]
    end

    def initial_zones_hash
      @initial_zones_hash ||= subject.domain_bindings
        .map(&:full_name)
        .zip(subject.actor.root.all_numbers || [nil])
        .each_with_object({}) do |(name, actor_nr), hash|
          hash[StringSubstituter.result_for(name, actor_nr:)] = []
        end
    end

    def specs
      authorized_scope(subject.virtual_machines)
        .joins(:connection_nic)
        .includes(
          :customization_specs,
          :actor,
          :numbered_by,
          { connection_nic: { network: [:address_pools, :exercise] } },
          { addresses: [:address_pool, { domain_binding: [:domain] }, { network: [:address_pools, :actor] }] }
        )
        .reorder(nil)
        .flat_map(&:customization_specs)
    end
end
