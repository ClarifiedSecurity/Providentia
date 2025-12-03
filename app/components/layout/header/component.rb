# frozen_string_literal: true

class Layout::Header::Component < ApplicationViewComponent
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
end
