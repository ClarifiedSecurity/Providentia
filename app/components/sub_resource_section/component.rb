# frozen_string_literal: true

class SubResourceSection::Component < ApplicationViewComponent
  renders_many :buttons

  attr_reader :header

  def initialize(header:)
    @header = header
  end
end
