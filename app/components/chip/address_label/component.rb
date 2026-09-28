# frozen_string_literal: true

class Chip::AddressLabel::Component < Chip::Component
  param :address

  def render? = address.fixed? && address.special_range

  private
    def value = I18n.t("special_ranges.#{address.special_range}").presence || address.special_range.to_s.humanize
    def flavor = :orange
end
