# frozen_string_literal: true

class AddOwnerToCustomizationSpec < ActiveRecord::Migration[8.0]
  def change
    add_reference :customization_specs, :user, null: true, foreign_key: true
  end
end
