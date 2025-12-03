# frozen_string_literal: true

class Tooltip::AddressPool::Component < Tooltip::Component
  option :skip_prefix, optional: true, default: false

  private
    def template_text
      @object.network_address.dup.tap do |address|
        address.gsub!(/\/\d+\z/, '') if skip_prefix
      end
    end
end
