# frozen_string_literal: true

class CreateCredentialBindings < ActiveRecord::Migration[7.2]
  def change
    create_table :credential_bindings do |t|
      t.references :credential_set, null: false, foreign_key: true
      t.references :customization_spec, null: false, foreign_key: true

      t.timestamps
    end
  end
end
