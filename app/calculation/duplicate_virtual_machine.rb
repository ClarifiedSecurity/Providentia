# frozen_string_literal: true

class DuplicateVirtualMachine < Patterns::Calculation
  EXCLUDED_ATTRIBUTES = %w[id name hostname system_owner_id created_at updated_at].freeze
  STATIC_MODES = %w[ipv4_static ipv6_static].freeze

  private
    def result
      VirtualMachine.transaction do
        copy = VirtualMachine.create!(
          subject.attributes.except(*EXCLUDED_ATTRIBUTES).merge('name' => options[:name], 'system_owner' => options[:user])
        )

        copy.update!(visibility: subject.visibility) if copy.visibility != subject.visibility
        copy_host_spec(copy)
        copy_container_specs(copy)
        copy_network_interfaces(copy)

        copy.reload
      end
    end

    def copy_host_spec(copy)
      copy.host_spec.update!(spec_attributes(subject.host_spec))
    end

    def copy_container_specs(copy)
      subject.customization_specs.mode_container.order(:id).each do |spec|
        # capabilities are assigned after creation: the HABTM callback touches the record
        copied = copy.customization_specs.create!(
          spec_attributes(spec).except(:capability_ids).merge(mode: 'container', name: spec.name, user: options[:user])
        )
        copied.update!(capability_ids: spec.capability_ids)
      end
    end

    def spec_attributes(spec)
      {
        role_name: spec.role_name,
        description: spec.description,
        cluster_mode: spec.cluster_mode,
        tag_list: spec.tag_list.join(', '),
        capability_ids: spec.capability_ids
      }
    end

    def copy_network_interfaces(copy)
      subject.network_interfaces.includes(:addresses).order(:id).each do |source_nic|
        nic = copy.network_interfaces.create!(network_id: source_nic.network_id, egress: source_nic.egress)
        # network_change_cleanup auto-creates one address per pool on create; replace with the source's addresses
        nic.addresses.reload.destroy_all

        source_nic.addresses.sort_by(&:id).each do |address|
          nic.addresses.create!(
            mode: address.mode,
            address_pool_id: address.address_pool_id,
            offset: STATIC_MODES.include?(address.mode) ? nil : address.offset,
            dns_enabled: address.dns_enabled,
            connection: address.connection,
            domain_binding_id: address.domain_binding_id
          )
        end
      end
    end
end
