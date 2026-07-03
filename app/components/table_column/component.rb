# frozen_string_literal: true

class TableColumn::Component < ApplicationViewComponent
  include ViewComponentContrib::StyleVariants

  option :classes, optional: true
  option :id, optional: true
  option :size, optional: true

  style do
    base {
      %w[text-left text-xs text-gray-500 dark:text-gray-300 uppercase tracking-wider]
    }
    variants {
      size {
        sm {
          %w[px-3 py-2]
        }
        md {
          %w[px-6 py-3]
        }
      }
    }
    defaults { { size: :md } }
  end
end
