# frozen_string_literal: true

class RemoveOldCapabilityAssociations < ActiveRecord::Migration[7.1]
  def up
    drop_table :capabilities_networks
    drop_table :capabilities_virtual_machines
  end
end
