# frozen_string_literal: true

class Domain < ApplicationRecord
  extend FriendlyId
  friendly_id :name # , use: :slugged

  belongs_to :exercise
  has_many :domain_bindings, dependent: :destroy
  has_many :networks, through: :domain_bindings
end
