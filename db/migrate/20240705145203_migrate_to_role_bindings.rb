# frozen_string_literal: true

class MigrateToRoleBindings < ActiveRecord::Migration[7.1]
  def change
    Exercise.all.each do |ex|
      create_gt_binding(ex) if ex.attributes['dev_resource_name'] # gt
      create_rt_binding(ex) if ex.attributes['dev_red_resource_name'] # rt
      create_admin_binding(ex) if ex.attributes['local_admin_resource_name'] # admin
    end
  end

  private
    def create_gt_binding(ex)
      actor = ex.actors.find_by(abbreviation: 'gt')
      return if !actor
      ex.role_bindings.where(
        user_resource: Rails.configuration.resource_prefix + ex.attributes['dev_resource_name'],
        actor:,
        role: :actor_dev
      ).first_or_create
    end

    def create_rt_binding(ex)
      actor = ex.actors.find_by(abbreviation: 'gt')
      return if !actor
      ex.role_bindings.where(
        user_resource: Rails.configuration.resource_prefix + ex.attributes['dev_red_resource_name'],
        actor:,
        role: :actor_dev
      ).first_or_create
    end

    def create_admin_binding(ex)
      ex.role_bindings.where(
        user_resource: Rails.configuration.resource_prefix + ex.attributes['local_admin_resource_name'],
        role: :environment_admin
      ).first_or_create
    end
end
