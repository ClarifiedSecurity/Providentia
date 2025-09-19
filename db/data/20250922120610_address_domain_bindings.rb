# frozen_string_literal: true

class AddressDomainBindings < ActiveRecord::Migration[8.0]
  def up
    Address.reset_column_information

    Address.includes(:network).where(dns_enabled: true).find_each do |address|
      next if address.network.nil? || address.network.domain_bindings.empty?

      domain_binding = address.network.domain_bindings.first
      address.update_columns(domain_binding_id: domain_binding.id)
    end
  end

  def down
    Address.update_all(domain_binding_id: nil)
  end
end
