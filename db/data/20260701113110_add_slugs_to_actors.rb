# frozen_string_literal: true

class AddSlugsToActors < ActiveRecord::Migration[8.1]
  def up
    Actor.where(slug: nil).each(&:save)
  end

  def down
    Actor.update_all(slug: nil)
  end
end
