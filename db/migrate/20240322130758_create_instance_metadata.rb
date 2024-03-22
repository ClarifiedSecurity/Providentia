# frozen_string_literal: true

class CreateInstanceMetadata < ActiveRecord::Migration[7.1]
  def change
    create_table :instance_metadata do |t|
      t.references :customization_spec, null: false, foreign_key: true
      t.string :instance, null: false
      t.jsonb :metadata, default: {}, null: false

      t.timestamps
    end
  end
end
