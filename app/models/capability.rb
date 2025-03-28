# frozen_string_literal: true

class Capability < ApplicationRecord
  extend FriendlyId

  belongs_to :exercise, touch: true
  has_and_belongs_to_many :customization_specs
  has_and_belongs_to_many :actors, touch: true

  validates :name, uniqueness: { scope: :exercise }, presence: true

  friendly_id :name, use: [:slugged, :scoped], scope: :exercise

  def self.to_icon
    'fa-layer-group'
  end

  private
    def should_generate_new_friendly_id?
      name_changed? || super
    end
end
