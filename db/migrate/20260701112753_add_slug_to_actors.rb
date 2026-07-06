# frozen_string_literal: true

class AddSlugToActors < ActiveRecord::Migration[8.1]
  def change
    add_column :actors, :slug, :string
  end
end
