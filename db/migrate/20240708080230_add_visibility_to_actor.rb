# frozen_string_literal: true

class AddVisibilityToActor < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :default_visibility, :integer, default: 1
  end
end
