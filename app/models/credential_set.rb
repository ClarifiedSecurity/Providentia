# frozen_string_literal: true

class CredentialSet < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :scoped], scope: :exercise
  has_paper_trail

  belongs_to :exercise
  belongs_to :network, optional: true
  has_many :credentials, dependent: :destroy
  has_many :credential_bindings, dependent: :destroy

  validates :name, uniqueness: { scope: :exercise }, presence: true

  def self.to_icon
    'fa-key'
  end

  def network_domain_prefix
    network.full_domain.split('.').first.upcase if network
  end
end
