# frozen_string_literal: true

class EmptylistingComponent < ViewComponent::Base
  attr_reader :klass

  def initialize(klass:)
    @klass = klass
  end
end
