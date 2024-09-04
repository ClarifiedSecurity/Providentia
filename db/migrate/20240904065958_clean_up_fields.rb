# frozen_string_literal: true

class CleanUpFields < ActiveRecord::Migration[7.1]
  def up
    # now on actors
    remove_column :exercises, :blue_team_count
    remove_column :exercises, :dev_team_count

    # team ids
    remove_column :networks, :team_id
    remove_column :virtual_machines, :team_id

    # old visiblity
    remove_column :virtual_machines, :bt_visible
  end
end
