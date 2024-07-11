# frozen_string_literal: true

class AddResourcesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :resources, :jsonb, default: []
  end
end
