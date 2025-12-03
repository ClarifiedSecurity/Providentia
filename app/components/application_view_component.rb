# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer

  private
    def controller_class
      controller_path.classify.constantize
    end

    def controller_item
      controller.instance_variable_get("@#{controller_name.singularize}")
    end

    def exercise
      controller.instance_variable_get('@exercise')
    end
end
