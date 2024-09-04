# frozen_string_literal: true

class RemoveServiceChecks < ActiveRecord::Migration[7.1]
  def up
    drop_table :service_checks
  end
end
