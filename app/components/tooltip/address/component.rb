# frozen_string_literal: true

class Tooltip::Address::Component < Tooltip::Component
  with_collection_parameter :object

  def render?
    @object
  end

  private
    def template_text
      return 'N/A' if !@object.offset
      return 'dynamic' if !@object.fixed?
      AddressValues.result_for(@object) || UnsubstitutedAddress.result_for(@object)
    end
end
