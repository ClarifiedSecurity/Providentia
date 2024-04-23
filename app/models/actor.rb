# frozen_string_literal: true

class Actor < ApplicationRecord
  has_ancestry

  belongs_to :exercise

  has_many :networks
  has_many :virtual_machines
  has_many :actor_number_configs
  has_many :numbered_virtual_machines, class_name: 'VirtualMachine', as: :numbered_by
  has_many :capabilities

  scope :numbered, -> {
    where.not(number: nil)
  }

  validates :number, numericality: { only_integer: true, greater_than: 0, allow_blank: true }

  before_save :set_exercise_from_parent

  def self.to_icon
    'fa-building-shield'
  end

  def red? # TEMPORARY
    abbreviation == 'rt'
  end

  def downcased_name
    name.downcase
  end

  def initials
    name.split(' ').map(&:first).map(&:upcase).join
  end

  def numbering
    return unless prefs['numbered']
    count = prefs.dig('numbered', 'count').presence || 0
    dev_count = prefs.dig('numbered', 'dev_count').presence || 0
    {
      entries: 1.step(by: 1).take(count + dev_count),
      dev_entries: (count + 1).step(by: 1).take(dev_count)
    }
  end

  def all_numbers
    return if !number?
    1.upto(number).to_a
  end

  def ui_color
    parent&.ui_color || prefs&.dig('ui_color') || 'gray'
  end

  private
    def set_exercise_from_parent
      return if exercise_id && !parent
      parent.exercise_id
    end
end
