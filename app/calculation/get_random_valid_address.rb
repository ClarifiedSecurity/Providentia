# frozen_string_literal: true

class GetRandomValidAddress < Patterns::Calculation
  attr_reader :address_pool

  private
    def result
      @address_pool = subject.address_pool
      new_random_address = subject.clone
      begin
        new_random_address.offset = rand(address_pool.ip_network.size - 2)
      end until new_random_address.valid?
      new_random_address.offset
    end

    def current_used_addresses
      @current_used_addresses ||= address_pool.addresses
        .where.not(id: subject.id)
        .where(mode: subject.mode)
        .all_ip_objects
    end

end