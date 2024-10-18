# frozen_string_literal: true

class CreateCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :credentials do |t|
      t.references :credential_set, null: false, foreign_key: true
      t.string :name, null: false
      t.string :password, null: false
      t.jsonb :config_map, null: false, default: {}

      t.timestamps
    end
  end
end
