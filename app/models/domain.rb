# frozen_string_literal: true

class Domain < ApplicationRecord
  belongs_to :exercise
  has_many :domain_bindings, dependent: :destroy
  has_many :networks, through: :domain_bindings

  validates :name,
    presence: true,
    uniqueness: { scope: :exercise },
    format: {
      with: /\A(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)*(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)\.?\z/,
      message: 'must be a valid domain name'
    }
end
