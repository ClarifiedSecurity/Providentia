# frozen_string_literal: true

class SpecDNSRecords < Patterns::Calculation
  ForwardRecord = Data.define(:zone, :network, :record) do
    def self.human
      'Forward record'
    end
  end
  ReverseRecord = Data.define(:zone, :network, :record) do
    def self.human
      'Reverse record'
    end
  end

  private
    def result
      Rails.cache.fetch(cache_key) do
        subject.deployable_instances(Presenter).flat_map(&:records)
      end
    end

    def cache_key
      [
        'spec_dns_records',
        subject.cache_key_with_version,
        subject.virtual_machine.cache_key_with_version
      ]
    end

    class Presenter
      def initialize(spec, sequential_number = nil, number = nil, **_opts)
        @spec = spec
        @sequential_number = sequential_number
        @number = number
      end

      def records
        @spec.virtual_machine.addresses
          .where(mode: %w(ipv4_static ipv4_vip ipv6_static ipv6_vip))
          .joins(:domain_binding)
          .flat_map do |address|
            Enumerator.new do |yielder|
              generator = HostnameGenerator.result_for(@spec, address:)

              yielder.yield generate_forward_record(address:, generator:)
              yielder.yield generate_reverse_record(address:, generator:)
            end.to_a.compact
          end
      end

      private
        def generate_forward_record(address:, generator:)
          zone = substitute_variables(generator.domain)

          ForwardRecord.new(zone, address.network, {
            type: address.ipv4? ? 'A' : 'AAAA',
            name: substitute_variables(generator.hostname),
            data: generate_ip_address(address).to_s
          })
        end

        def generate_reverse_record(address:, generator:)
          host, zone = generate_ip_address(address).ptr_record
          return unless host && zone

          ReverseRecord.new(zone, address.network, {
            type: 'PTR',
            name: host,
            data: "#{substitute_variables(generator.fqdn)}."
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
