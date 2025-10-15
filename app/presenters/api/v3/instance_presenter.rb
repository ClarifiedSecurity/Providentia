# frozen_string_literal: true

module API
  module V3
    class InstancePresenter
      attr_reader :spec, :sequential_number, :actor_number, :options
      delegate :operating_system, to: :vm

      AddressWithGenerator = Data.define(:address, :generator, :connection?)

      def initialize(spec, sequential_number = nil, actor_number = nil, **opts)
        @spec = spec
        @sequential_number = sequential_number
        @actor_number = actor_number
        @options = opts
      end

      def as_json
        return if skip_by_numbering

        {
          id:,
          parent_id:,
          vm_name:,
          team_unique_id:,
          hostname: substitute(primary_generator.generator.hostname.to_s),
          domain: substitute(primary_generator.generator.domain.to_s),
          fqdn: substitute(primary_generator.generator.fqdn.to_s),
          connection_address:,
          interfaces:,
          checks:,
          tags:,
          config_map: {}
        }.merge(actor_numbers)
         .merge(sequence_info)
         .merge(metadata)
      end

      private
        # --- VM and Spec Accessors ---

        def vm
          spec.virtual_machine
        end

        def host_spec
          # Set manually to avoid extra DB call
          vm.host_spec.tap { |hs| hs.virtual_machine = vm }
        end

        # --- ID and Hostname Generation ---

        def id
          substitute([spec.slug, hostname_sequence_suffix, hostname_team_suffix].compact.join('_'))
        end

        def parent_id
          return if spec.mode_host?

          substitute(
            [
              host_spec.slug,
              hostname_sequence_suffix,
              clustered_parent_suffix,
              hostname_team_suffix
            ].compact.join('_')
          )
        end

        def team_unique_id
          substitute([spec.slug, hostname_sequence_suffix].compact.join('_'))
        end

        def vm_name
          gen = HostnameGenerator.result_for(host_spec, address: primary_generator&.address)
          substitute("#{vm.exercise.abbreviation}_#{gen.fqdn}").downcase
        end

        def hostname_sequence_suffix
          '{{ seq }}' if vm.clustered? && spec.cluster_mode?
        end

        def hostname_team_suffix
          't{{ actor_nr_str }}' if vm.numbered_actor
        end

        def clustered_parent_suffix
          (vm.clustered? && !spec.cluster_mode?) ? '01' : nil
        end

        # --- Team and Sequence Info ---

        def actor_numbers
          return {} unless actor_number
          {
            team_nr: actor_number,
            team_nr_str: actor_number.to_s.rjust(2, '0'),
            actor_nr: actor_number,
            actor_nr_str: actor_number.to_s.rjust(2, '0'),
          }
        end

        def sequence_info
          return {} unless vm.clustered? && spec.cluster_mode?
          { sequence_index: sequential_number }
        end

        # --- Metadata ---

        def metadata
          return {} unless options[:include_metadata]
          {
            metadata: spec.instance_metadata.select(:metadata).find_by(instance: id)&.metadata
          }
        end

        # --- Numbering Logic ---

        def skip_by_numbering
          actor_number && vm.numbered_actor && !enabled_numbered_actors.include?(actor_number)
        end

        def enabled_numbered_actors
          if vm.numbered_by.is_a?(ActorNumberConfig)
            vm.numbered_by.matcher.map(&:to_i)
          else
            vm.numbered_actor.all_numbers
          end
        end

        # --- Substitution Helper ---

        def substitute(text)
          StringSubstituter.result_for(
            text,
            {
              actor_nr: actor_number,
              seq: sequential_number
            }
          )
        end

        # --- Connection Address ---

        def connection_address
          primary_generator.address&.ip_object(
            sequence_number: sequential_number,
            sequence_total: vm.custom_instance_count,
            actor_number: actor_number
          )&.to_s
        end

        # --- Network Interfaces and Addresses ---

        def network_interfaces
          Current.interfaces_cache ||= {}
          Current.interfaces_cache[vm.id]
        end

        def interfaces
          network_interfaces.map do |nic|
            namespec = HostnameGenerator.result_for(spec, fallback_domain: nic.network.domain_bindings&.first&.full_name)
            {
              network_id: nic.network.slug,
              nic_name: nic.nic_name,
              cloud_id: substitute(nic.network.cloud_id.to_s),
              domain: substitute(namespec.domain),
              fqdn: substitute(namespec.fqdn),
              egress: nic.egress?,
              connection: addresses_by_nic[nic].any?(&:connection?),
              addresses: addresses_by_nic[nic].map { |awg| address_json(awg, nic) }
            }
          end
        end

        def address_json(address_with_generator, nic)
          address, _, connection = address_with_generator.address, address_with_generator.generator, address_with_generator.connection?
          {
            connection: connection,
            pool_id: address.address_pool&.slug,
            mode: address.mode,
            dns_enabled: address.domain_binding.present?,
            address: static_address(address),
            gateway: gateway_address(address, nic)
          }
        end

        def static_address(address)
          return unless address.fixed?
          address.ip_object(
            sequence_number: sequential_number,
            sequence_total: vm.custom_instance_count,
            actor_number: actor_number
          ).to_string
        end

        def gateway_address(address, nic)
          return unless nic.egress? && (address.mode_ipv4_static? || address.mode_ipv6_static?)
          address.address_pool.gateway_ip(actor_number)&.to_s
        end

        def addresses_with_generator
          @addresses_with_generator ||= vm
            .addresses
            .order(:created_at)
            .filter_map do |addr|
              if !addr.fixed? || addr.offset.present?
                AddressWithGenerator.new(
                  addr,
                  HostnameGenerator.result_for(spec, address: addr, fallback_domain: addr.network.domain_bindings&.first&.full_name),
                  addr.connection?
                )
              end
            end
        end

        def addresses_by_nic
          @addresses_by_nic ||= Hash.new([]).merge(
            addresses_with_generator.group_by { |awg| awg.address.network_interface }
          )
        end

        def primary_generator
          addresses_with_generator.detect(&:connection?) || fallback_generator
        end

        def fallback_generator
          AddressWithGenerator.new(nil, HostnameGenerator.result_for(spec), false)
        end

        # --- Checks and Tags ---

        def checks
          Current.services_cache ||= {}
          Current.services_cache[spec.id] ||= Check
            .joins(:service)
            .merge(Service.for_spec(spec))
            .flat_map(&:slugs)
            .map(&:last)
          Current.services_cache[spec.id].map do |check_name|
            {
              id: check_name,
              budget_id: "#{team_unique_id}_#{check_name}",
              exercise_unique_id: "#{id}_#{check_name}"
            }
          end
        end

        def tags
          GenerateTags.result_for(self).map(&:id)
        end
    end
  end
end
