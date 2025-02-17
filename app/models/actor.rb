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

# For tailwind to discover all the classes
# bg-slate-200 bg-slate-500 dark:bg-slate-700 dark:text-slate-300 dark:bg-slate-500 dark:text-slate-700 text-slate-600 text-slate-800
# bg-amber-200 bg-amber-500 dark:bg-amber-700 dark:text-amber-300 dark:bg-amber-500 dark:text-amber-700 text-amber-600 text-amber-800
# bg-emerald-200 bg-emerald-500 dark:bg-emerald-700 dark:text-emerald-300 dark:bg-emerald-500 dark:text-emerald-700 text-emerald-600 text-emerald-800
# bg-rose-200 bg-rose-500 dark:bg-rose-700 dark:text-rose-300 dark:bg-rose-500 dark:text-rose-700 text-rose-600 text-rose-800
# bg-sky-200 bg-sky-500 dark:bg-sky-700 dark:text-sky-300 dark:bg-sky-500 dark:text-sky-700 text-sky-600 text-sky-800
# bg-orange-200 bg-orange-500 dark:bg-orange-700 dark:text-orange-300 dark:bg-orange-500 dark:text-orange-700 text-orange-600 text-orange-800
# bg-violet-200 bg-violet-500 dark:bg-violet-700 dark:text-violet-300 dark:bg-violet-500 dark:text-violet-700 text-violet-600 text-violet-800