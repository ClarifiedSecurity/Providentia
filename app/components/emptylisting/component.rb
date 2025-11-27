# frozen_string_literal: true

class Emptylisting::Component < ApplicationViewComponent
  attr_reader :klass

  def initialize(klass:)
    @klass = klass
  end
end
