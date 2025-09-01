# frozen_string_literal: true

class CreateDomains < ActiveRecord::Migration[8.0]
  def change
    create_table :domains do |t|
      t.references :exercise, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
