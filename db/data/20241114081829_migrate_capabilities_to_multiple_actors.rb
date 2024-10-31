# frozen_string_literal: true

class MigrateCapabilitiesToMultipleActors < ActiveRecord::Migration[7.2]
  def up
    Capability.all.each do |cap|
      if cap.actor_id
        cap.actors << Actor.find(cap.actor_id)
        cap.save
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
