# frozen_string_literal: true

class Layout::TwoColumn::Component < ApplicationViewComponent
  renders_one :description
  renders_one :main

  option :shadow, optional: true, default: -> { false }
end
