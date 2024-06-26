# frozen_string_literal: true

class Service < ApplicationRecord
  include VmCacheBuster
  include SpecCacheUpdateOnSave
  include SpecCacheUpdateBeforeDestroy
  extend FriendlyId
  friendly_id :name, use: [:slugged, :scoped], scope: :exercise, sequence_separator: '_'

  has_paper_trail

  belongs_to :exercise
  has_many :service_subjects, dependent: :destroy
  has_many :checks, dependent: :destroy

  has_and_belongs_to_many :customization_specs

  validates :name, uniqueness: { scope: :exercise }, presence: true, length: { minimum: 1, maximum: 63 }

  scope :for_spec, ->(*specs) {
    joins(:service_subjects)
      .where('service_subjects.customization_spec_ids @> :id::jsonb', id: specs.flatten.map(&:id).to_json)
      .distinct
  }

  def self.to_icon
    'fa-flask'
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def cached_spec_ids
    service_subjects.pluck(:customization_spec_ids).flatten
  end
end
