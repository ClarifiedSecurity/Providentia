# frozen_string_literal: true

class Actor < ApplicationRecord
  ALLOWED_COLORS = %w(slate amber emerald rose sky orange violet).freeze

  has_ancestry

  attribute :default_visibility, :integer # rails bug during migrations
  enum :default_visibility, { public: 1, actor_only: 2  }, prefix: :default_visibility

  belongs_to :exercise, touch: true

  has_many :networks
  has_many :virtual_machines
  has_many :actor_number_configs
  has_many :numbered_virtual_machines, class_name: 'VirtualMachine', as: :numbered_by
  has_many :capabilities
  has_many :role_bindings
  has_and_belongs_to_many :capabilities

  scope :numbered, -> {
    where.not(number: nil)
  }

  validates :number, numericality: { only_integer: true, greater_than: 0, allow_blank: true }

  before_save :set_exercise_from_parent

  def self.to_icon
    'fa-building-shield'
  end

  def downcased_name
    name.downcase
  end

  def initials
    name.split(' ').map(&:first).map(&:upcase).join
  end

  def all_numbers
    return if !number?
    1.upto(number).to_a
  end

  def ui_color
    parent&.ui_color || prefs&.dig('ui_color') || 'gray'
  end

  def ui_color=(value)
    return if !ALLOWED_COLORS.include?(value)
    prefs['ui_color'] = value
  end

  private
    def set_exercise_from_parent
      return if exercise_id && !parent
      parent.exercise_id
    end
end
