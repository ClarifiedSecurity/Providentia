# frozen_string_literal: true

class Exercise < ApplicationRecord
  extend FriendlyId
  friendly_id :abbreviation, use: :slugged
  has_paper_trail

  enum :mode, { exercise: 1, infra: 2 }, prefix: :mode

  has_many :actors, dependent: :destroy
  has_many :role_bindings, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :virtual_machines, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :service_subjects, through: :services
  has_many :capabilities, dependent: :destroy
  has_many :credential_sets, dependent: :destroy
  has_many :address_pools, through: :networks
  has_many :addresses, through: :virtual_machines
  has_many :customization_specs, through: :virtual_machines

  after_create :create_default_actors

  validates :name, :abbreviation, presence: true
  validates :abbreviation, uniqueness: true

  scope :active, -> { where(archived: false) }
  scope :search, ->(query) {
    columns = %w{
      exercises.name exercises.abbreviation
      actors.name actors.abbreviation
    }
    left_outer_joins(:actors)
      .where(
        columns
          .map { |c| "#{c} ilike :search" }
          .join(' OR '),
        search: "%#{query}%"
      )
      .group(:id)
  }
  scope :for_user, ->(user) {
    joins(:role_bindings)
      .merge(RoleBinding.for_user(user))
  }

  def self.to_icon
    'fa-project-diagram'
  end

  # friendlyid override
  def should_generate_new_friendly_id?
    abbreviation_changed? || super
  end

  private
    def create_default_actors
      actors
        .where(abbreviation: 'infra')
        .first_or_create(name: 'Infrastructure', prefs: { ui_color: 'emerald' })

      actors
        .where(abbreviation: 'rt')
        .first_or_create(name: 'Red team', prefs: { ui_color: 'rose' })

      actors
        .where(abbreviation: 'bt')
        .first_or_create(name: 'Blue teams', prefs: { ui_color: 'sky' })
    end
end
