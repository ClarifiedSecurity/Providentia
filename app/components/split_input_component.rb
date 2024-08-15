# frozen_string_literal: true

class SplitInputComponent < ViewComponent::Base
  renders_many :left_cells
  renders_many :right_cells
  renders_one :input, ->(form_helper:, field:, method: :text_field, **kwargs) do
    kwargs[:class] = 'w-full border-0 bg-transparent focus:ring-indigo-500 dark:placeholder:text-gray-400 disabled:cursor-not-allowed disabled:opacity-75'
    form_helper.public_send(method, field, kwargs)
  end
end
