# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_before_action :load_exercises

  def index
    @exercises =
      authorized_scope(Exercise.all, scope_options: { with_archived: params[:archived] })
      .includes(:services)
      .order(:name)

    @my_exercises, @other_exercises = @exercises.partition do |ex|
      ex.virtual_machines.where(system_owner: current_user).exists?
    end
  end
end
