# frozen_string_literal: true

class DomainBinding < ApplicationRecord
  belongs_to :network, touch: true
  belongs_to :domain

  scope :subdomain_ordering, -> {
    order(Arel.sql("array_length(string_to_array(domain_bindings.name, '.'), 1) asc nulls first, domain_bindings.name asc"))
  }

  def self.full_names
    all.includes(:domain).filter_map(&:full_name)
  end

  def full_name
    [name, domain.name].reject(&:blank?).join('.')
  end
end
