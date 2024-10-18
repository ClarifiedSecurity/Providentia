# frozen_string_literal: true

class Credential < ApplicationRecord
  belongs_to :credential_set, touch: true

  validates :name, :password, presence: true

  def self.to_icon
    'fa-key'
  end

  def email
    email_override || [username,domain_from_network].join('@')
  end

  def username
    username_override || ActiveSupport::Inflector.parameterize(name, separator: ".")
  end

  private
    def domain_from_network
      return unless credential_set.network
      credential_set.network.full_domain
    end
end
