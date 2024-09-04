# frozen_string_literal: true

class RemoveTeams < ActiveRecord::Migration[7.1]
  def up
    drop_table :teams
  end
end
