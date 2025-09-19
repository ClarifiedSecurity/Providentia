# frozen_string_literal: true

class AddDomainBindingToAddress < ActiveRecord::Migration[8.0]
  def change
    add_reference :addresses, :domain_binding, null: true, foreign_key: true
  end
end
