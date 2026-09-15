# frozen_string_literal: true

class Listing::Empty::Component < ApplicationViewComponent
  attr_reader :klass

  def initialize(klass:)
    @klass = klass
  end
end
