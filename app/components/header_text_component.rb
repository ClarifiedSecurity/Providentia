# frozen_string_literal: true

class HeaderTextComponent < ViewComponent::Base
  include ApplicationHelper
  BreadcrumbItem = Data.define(:url, :content, :icon) do
    def initialize(url:, content:, icon: nil)
      super(url:, content:, icon:)
    end
  end

  CrumbableControllers = %w[networks virtual_machines services capabilities credential_sets]
  CrumbableActions = %w[show edit]

  private
    def breadcrumb_items
      [].tap do |items|
        items << BreadcrumbItem.new(url: root_path, content: '', icon: :logo)
        items << BreadcrumbItem.new(url: [exercise], content: exercise.name) if exercise
        if CrumbableControllers.include?(controller_name)
          items << BreadcrumbItem.new(
            url: [exercise, controller_name.pluralize.to_sym],
            content: ar_class_to_link_text(controller_class),
            icon: controller_class.to_icon
          )
          if CrumbableActions.include?(action_name)
            items << BreadcrumbItem.new(
              url: [exercise, controller_item],
              content: controller_item.name
            )
          end
        end
      end
    end

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
