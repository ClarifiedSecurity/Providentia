# frozen_string_literal: true

class UpdateAncestryFormats < ActiveRecord::Migration[8.1]
  def up
    %w[actors operating_systems].each do |table_name|
      execute "UPDATE #{table_name} SET ancestry = CONCAT(ancestry, '/') WHERE ancestry IS NOT NULL"
      execute "UPDATE #{table_name} SET ancestry = '' WHERE ancestry IS NULL"
      change_column_null table_name, :ancestry, false
    end
  end

  def down
    %w[actors operating_systems].each do |table_name|
      change_column_null table_name, :ancestry, true
      execute "UPDATE #{table_name} SET ancestry = NULL WHERE ancestry = ''"
      execute "UPDATE #{table_name} SET ancestry = TRIM(TRAILING '/' FROM ancestry) WHERE ancestry IS NOT NULL"
    end
  end
end
