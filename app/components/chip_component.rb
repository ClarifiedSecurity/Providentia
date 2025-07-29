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

# For tailwind to discover all the classes
# bg-cyan-200 text-cyan-800 dark:bg-cyan-700 dark:text-cyan-300
# bg-stone-200 text-stone-800 dark:bg-stone-700 dark:text-stone-300
