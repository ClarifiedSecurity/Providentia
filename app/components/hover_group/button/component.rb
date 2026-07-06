# frozen_string_literal: true

class HoverGroup::Button::Component < ApplicationViewComponent
  include ViewComponentContrib::StyleVariants

  option :icon

  style do
    base {
      %w[inline-flex items-center px-3 py-2 text-center
      text-sm font-medium shadow-sm font-medium text-slate-700
      bg-transparent hover:bg-slate-700 hover:text-white
      focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white
      dark:border-white dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:bg-gray-700]
    }
  end
end
