# frozen_string_literal: true

class DomainBinding < ApplicationRecord
  belongs_to :network
  belongs_to :domain

  def full_name
    [name, domain.name].compact.join('.')
  end
end
