# frozen_string_literal: true

class DNSZones < Patterns::Calculation
  include ActionPolicy::Behaviour
  authorize :user, through: :current_user

  ForwardRecord = Data.define(:zone, :record)
  ReverseRecord = Data.define(:zone, :record)

  private
    def result
      Rails.cache.fetch(cache_key) do
        build_initial_zones_hash.tap do |zones_hash|
          populate_dns_records(zones_hash)
        end
      end
    end

    def current_user
      Current.user
    end

    def cache_key
      [
        'dns_zones',
        authorized_scope(Exercise.all).cache_key_with_version,
        authorized_scope(subject.actors).cache_key_with_version,
        authorized_scope(subject.networks).cache_key_with_version,
        authorized_scope(subject.customization_specs).cache_key_with_version
      ]
    end

    def build_initial_zones_hash
      authorized_scope(subject.networks).each_with_object({}) do |network, hash|
        generate_zones(network) { hash[it] = [] }
      end
    end

    def generate_zones(network)
      if network.actor.root.number?
        network.actor.root.all_numbers.each do |number|
          yield StringSubstituter.result_for(network.full_domain, team_nr: number)
        end
      else
        yield network.full_domain
      end
    end

    def populate_dns_records(zones_hash)
      optimized_specs.select { it.virtual_machine.connection_nic }.each do |spec|
        spec.deployable_instances(Presenter).each do |instance|
          instance.results { |record|
            case record
            when ReverseRecord
              # create zone dynamically
              zones_hash[record.zone] ||= []
              zones_hash[record.zone] << record.record
            when ForwardRecord
              # zone not existing means network is not accessible to current user
              zones_hash[record.zone] << record.record if zones_hash[record.zone]
            end
          }
        end
      end
    end

    def optimized_specs
      authorized_scope(subject.customization_specs)
        .includes(
          virtual_machine: [
            { connection_nic: { network: [:exercise] } },
            { addresses: [:address_pool, { network: [:actor] }] }
          ]
        )
    end

    class Presenter
      def initialize(spec, sequential_number = nil, number = nil, **_opts)
        @spec = spec
        @sequential_number = sequential_number
        @number = number
      end

      def results
        @spec.virtual_machine.addresses
          .select(&:dns_enabled?)
          .each do |address|
            namespec = HostnameGenerator.result_for(@spec, nic: address.network_interface)

            yield generate_forward_record(address:, namespec:)
            yield generate_reverse_record(address:, namespec:)
          end
      end

      private
        def generate_forward_record(address:, namespec:)
          zone = substitute_variables(namespec.domain)

          ForwardRecord.new(zone, {
            type: address.ipv4? ? 'A' : 'AAAA',
            name: substitute_variables(namespec.hostname),
            data: generate_ip_address(address).to_s
          })
        end

        def generate_reverse_record(address:, namespec:)
          host, zone = generate_ip_address(address).ptr_record
          return unless host && zone

          ReverseRecord.new(zone, {
            type: 'PTR',
            name: host,
            data: "#{substitute_variables(namespec.fqdn)}."
          })
        end

        def generate_ip_address(address)
          address.ip_object(
            sequence_number: @sequential_number,
            sequence_total: @spec.virtual_machine.custom_instance_count,
            actor_number: @number
          )
        end

        def substitute_variables(text)
          StringSubstituter.result_for(
            text,
            team_nr: @number,
            seq: @sequential_number
          )
        end
    end
end
