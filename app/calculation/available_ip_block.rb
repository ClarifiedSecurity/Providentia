# frozen_string_literal: true

class AvailableIPBlock < Patterns::Calculation
  delegate :network_interface, :address_pool, :virtual_machine, :network, to: :subject

  private
    def result
      return [] unless subject.ipv4?

      search_space.map do |address|
        [
          address,
          Set.new(address.to_i.step.take(reserve_amount).map { |u32| IPAddress::IPv4.parse_u32(u32, address.prefix) })
        ]
      end.reject do |address, next_addresses|
        addresses_outside_of_search_space?(next_addresses) || addresses_in_used_block?(next_addresses)
      end.map(&:first)
    end

    def reserve_amount
      return @reserve_amount if defined?(@reserve_amount)
      @reserve_amount = [virtual_machine.custom_instance_count.to_i, 1].max
      @reserve_amount *= virtual_machine.team_numbers.size if !network.numbered? && virtual_machine.team_numbers
      @reserve_amount
    end

    def search_space
      @search_space ||= Set.new(address_pool.available_range)
    end

    def used_ipv4
      @used_ipv4 ||= Rails.cache.fetch([address_pool.addresses.cache_key_with_version, 'used_ipv4']) do
        Set.new(
          address_pool
            .addresses
            .mode_ipv4_static
            .where.not(id: network_interface.addresses.mode_ipv4_static.pluck(:id))
            .all_ip_objects
        )
      end
    end

    def addresses_in_used_block?(addresses)
      (used_ipv4 & addresses).any?
    end

    def addresses_outside_of_search_space?(addresses)
      (search_space & addresses).size < reserve_amount
    end
end
