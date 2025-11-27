# frozen_string_literal: true

class Tooltip::AddressNetworkPart::Component < Tooltip::Component
  private
    def template_text
      @object.ip_family_network_template.gsub(/\/\d+\z/, '')
    end
end
