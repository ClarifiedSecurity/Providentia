# frozen_string_literal: true

class SubResourceSectionComponent < ViewComponent::Base
  renders_many :buttons

  attr_reader :header

  def initialize(header:)
    @header = header
  end
end
