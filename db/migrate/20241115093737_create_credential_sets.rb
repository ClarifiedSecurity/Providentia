# frozen_string_literal: true

class CreateCredentialSets < ActiveRecord::Migration[7.2]
  def change
    create_table :credential_sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :network, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description

      t.timestamps
    end
  end
end
