# frozen_string_literal: true

class GetRandomValidAddress < Patterns::Calculation
  attr_reader :address_pool

  private
    def result
      @address_pool = subject.address_pool
      return :network_too_small if network_too_small
      return :no_contiguous_block_available if no_contiguous_block_available

      case subject.ip_family
      when :ipv4
        get_random_ipv4
      when :ipv6
        get_random_ipv6
      end
    end

    def get_random_ipv4
      available_ipv4_addresses.sample.u32 - address_pool.ip_network.network_u32 - 1
    end

    def get_random_ipv6
      tries = 0

      new_random_address = subject.clone
      begin
        tries += 1
        new_random_address.offset = rand(address_pool.ip_network.size)
      end until (new_random_address.valid? || tries >= 10)
      new_random_address.offset
    end

    def available_ipv4_addresses = AvailableIPBlock.result_for(subject)
    def addresses_needed = subject.virtual_machine.deployable_instances.size
    def network_too_small = addresses_needed > address_pool.ip_network.size

    def no_contiguous_block_available
      case subject.ip_family
      when :ipv4
        available_ipv4_addresses.empty?
      when :ipv6
        address_pool.addresses.mode_ipv6_static.flat_map(&:all_ip_objects).size / address_pool.ip_network.size > 0.9
      end
    end
end
