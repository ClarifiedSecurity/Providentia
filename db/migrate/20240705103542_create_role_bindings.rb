# frozen_string_literal: true

class CreateRoleBindings < ActiveRecord::Migration[7.1]
  def change
    create_table :role_bindings do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :actor, null: true, foreign_key: true
      t.integer :role
      t.string :user_email
      t.string :user_resource

      t.timestamps
    end
  end
end
