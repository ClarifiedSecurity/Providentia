# frozen_string_literal: true

class RoleBindingsController < ApplicationController
  before_action :get_exercise

  def create
    @role_binding = @exercise.role_bindings.build
    authorize! @role_binding
    @access_form = AddAccessForm.new(@role_binding, params[:access]).as(current_user)

    if @access_form.save
      redirect_to [:edit, @exercise]
    else # errors
    end
  end

  def destroy
    @role_binding = authorized_scope(@exercise.role_bindings).find(params[:id])
    authorize! @role_binding

    if @role_binding.destroy
      redirect_to [:edit, @exercise]
    end
  end
end
