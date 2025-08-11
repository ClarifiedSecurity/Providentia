# frozen_string_literal: true

class HeaderTextComponent < ViewComponent::Base
  CrumbableControllers = %w[networks virtual_machines services capabilities credential_sets operating_systems]
  CrumbableActions = %w[show edit]

  private
    def breadcrumb_items
      [].tap do |items|
        items << :root
        items << exercise if exercise&.persisted?
        if CrumbableControllers.include?(controller_name)
          items << controller_class
          items << controller_item if CrumbableActions.include?(action_name)
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
