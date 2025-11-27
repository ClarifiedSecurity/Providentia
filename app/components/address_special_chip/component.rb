# frozen_string_literal: true

class AddressSpecialChip::Component < ApplicationViewComponent
  attr_reader :address

  def initialize(address:)
    @address = address
  end

  def render?
    address.fixed? && address.special_range
  end

  def range_label
    I18n.t("special_ranges.#{address.special_range}").presence || address.special_range.to_s.humanize
  end
end
