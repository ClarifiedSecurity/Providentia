# frozen_string_literal: true

class AddClusterModeToCustomizationSpecs < ActiveRecord::Migration[7.1]
  def change
    add_column :customization_specs, :cluster_mode, :boolean, default: true
  end
end
