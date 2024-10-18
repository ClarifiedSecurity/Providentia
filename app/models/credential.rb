# frozen_string_literal: true

class Credential < ApplicationRecord
  has_paper_trail
  belongs_to :credential_set, touch: true

  validates :name, :password, presence: true

  def self.to_icon
    'fa-key'
  end

  def self.generate_password
    SecureRandom.alphanumeric(12)
  end

  def email
    [config_map['email'].presence || username, domain_from_network].join('@')
  end

  def username
    config_map['username'].presence || ActiveSupport::Inflector.parameterize(name, separator: '.')
  end

  def config_map_as_yaml
    config_map.to_yaml
  end

  private
    def domain_from_network
      return unless credential_set.network
      credential_set.network.full_domain
    end
end
