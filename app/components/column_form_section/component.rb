# frozen_string_literal: true

class ColumnFormSection::Component < ApplicationViewComponent
  renders_one :description
  renders_one :main

  def initialize(shadow: true)
    @shadow = shadow
  end
end
