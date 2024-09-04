# frozen_string_literal: true

class RemoveSpecialChecks < ActiveRecord::Migration[7.1]
  def up
    drop_table :special_checks
  end
end
