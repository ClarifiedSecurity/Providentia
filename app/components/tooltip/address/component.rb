# frozen_string_literal: true

class Tooltip::Address::Component < Tooltip::Component
  with_collection_parameter :object

  def render?
    @object && @object.offset || !@object.fixed?
  end

  private
    def template_text
      AddressValues.result_for(@object) || UnsubstitutedAddress.result_for(@object) || 'N/A or dynamic'
    end
end
