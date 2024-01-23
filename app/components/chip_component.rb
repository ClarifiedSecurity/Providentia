# frozen_string_literal: true

class ChipComponent < ViewComponent::Base
  with_collection_parameter :name

  def initialize(name:, icon: nil, flavor: 'stone')
    @name = name
    @flavor = flavor
    @icon = icon
  end

  private
    def color_classes
      "bg-#{@flavor}-200 text-#{@flavor}-800 dark:bg-#{@flavor}-700 dark:text-#{@flavor}-300"
    end
end
