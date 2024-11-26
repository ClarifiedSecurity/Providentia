# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_before_action :load_exercises

  def index
    @exercises = authorized_scope(Exercise.all).order(name: :asc)

    @my_exercises, @other_exercises = @exercises.partition do |ex|
      ex.virtual_machines.where(system_owner: current_user).exists?
    end

    @archived_exercises =
      authorized_scope(Exercise.all, scope_options: { with_archived: params[:archived] })
        .order(archived: :asc, name: :asc)
        .where(archived: true)
  end
end
