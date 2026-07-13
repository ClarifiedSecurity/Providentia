# frozen_string_literal: true

class AddVirtualizedRootCacheColumnsToAncestryModels < ActiveRecord::Migration[8.1]
  def change
    %w[actors operating_systems].each do |table_name|
      add_column table_name, :root_id, :virtual,
        type: :integer,
        as: "CASE WHEN #{table_name}.ancestry = '' THEN #{table_name}.id ELSE CAST(SUBSTR(#{table_name}.ancestry, 1, STRPOS(#{table_name}.ancestry, '/')-1) AS INTEGER) END",
        stored: true,
        null: true
      add_index table_name, :root_id
    end
  end
end
