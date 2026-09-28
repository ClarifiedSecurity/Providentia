# frozen_string_literal: true

class Layout::ResourceSection::Component < ApplicationViewComponent
  renders_many :buttons

  option :header
end
