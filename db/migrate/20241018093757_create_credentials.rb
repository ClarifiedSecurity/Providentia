# frozen_string_literal: true

class CreateCredentials < ActiveRecord::Migration[7.2]
  def change
    create_table :credentials do |t|
      t.references :credential_set, null: false, foreign_key: true
      t.string :name, null: false
      t.string :password, null: false
      t.string :username_override
      t.string :email_override
      t.text :description #??
      t.boolean :read_only, null: false, default: false
      t.jsonb :config_map, default: {}, null: false

      t.timestamps
    end
  end
end
