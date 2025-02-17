# frozen_string_literal: true

class AddOwnersToSpecs < ActiveRecord::Migration[8.0]
  def up
    CustomizationSpec.find_each do |spec|
      spec.update_columns(user_id: spec.virtual_machine.system_owner_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
