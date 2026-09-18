# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer

  delegate :current_user, :allowed_to?, :authorized_scope, to: :controller

  private
    def controller_class = controller_path.classify.constantize
    def controller_var(var) = controller.instance_variable_get("@#{var}")
    def controller_item = controller_var controller_name.singularize
    def exercise = controller_var :exercise

    def title(title)
      content_for(:title) { title }
    end
end
