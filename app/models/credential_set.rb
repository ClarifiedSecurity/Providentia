# frozen_string_literal: true

class CredentialSet < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :scoped], scope: :exercise
  has_paper_trail

  belongs_to :exercise
  belongs_to :network, optional: true
  has_many :credentials, dependent: :destroy
  has_many :credential_bindings, dependent: :destroy
  has_many :customization_specs, through: :credential_bindings

  validates :name, presence: true

  def self.to_icon
    'fa-key'
  end
end
