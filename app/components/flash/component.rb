# frozen_string_literal: true

class Flash::Component < ApplicationViewComponent
  include ViewComponentContrib::StyleVariants

  with_collection_parameter :message

  style do
    base {
      %w[border-l-4]
    }
    variants {
      type {
        notice {
          %w[bg-green-400 border-green-700 text-white]
        }
        error {
          %w[bg-red-400 border-red-700 text-black]
        }
        alert {
          %w[bg-red-400 border-red-700 text-black]
        }
      }
    }
  end

  attr_reader :type, :text

  def initialize(message:)
    @type, @text = message
    @type = @type.to_sym
  end
end
