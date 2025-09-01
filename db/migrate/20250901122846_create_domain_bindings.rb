# frozen_string_literal: true

class CreateDomainBindings < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_bindings do |t|
      t.references :network, null: false, foreign_key: true
      t.references :domain, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
