# frozen_string_literal: true

class CredentialSet < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :scoped], scope: :exercise
  has_paper_trail

  belongs_to :exercise
  belongs_to :network, optional: true
  has_many :credentials

  validates :name, presence: true

  def self.to_icon
    'fa-key'
  end
end
