# frozen_string_literal: true

class AddVisibilityToNetworks < ActiveRecord::Migration[7.1]
  def change
    add_column :networks, :visibility, :integer, default: 1
  end
end
