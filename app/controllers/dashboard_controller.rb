# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_before_action :load_exercises

  def index
    @owned_specs_count = authorized_scope(current_user.customization_specs).count
    @latest_stuff = authorized_scope(current_user.virtual_machines).order(updated_at: :desc).distinct.limit(5)
    @exercises = authorized_scope(Exercise.all).order(name: :asc)
    role_bound_ex_ids = RoleBinding.for_user(current_user).pluck(:exercise_id)

    @my_exercises, @other_exercises = @exercises.partition do |ex|
      role_bound_ex_ids.include? ex.id
    end

    @archived_exercises =
      authorized_scope(Exercise.all, scope_options: { with_archived: params[:archived] })
        .order(archived: :asc, name: :asc)
        .where(archived: true)
  end
end
