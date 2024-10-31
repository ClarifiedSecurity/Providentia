# frozen_string_literal: true

class AddJoinTableForActorCapabilities < ActiveRecord::Migration[7.2]
  def change
    create_join_table :actors, :capabilities do |t|
      t.index [:actor_id, :capability_id], name: 'actor_capability_index'
    end
  end
end
