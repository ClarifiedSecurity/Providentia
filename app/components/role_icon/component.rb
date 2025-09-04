# frozen_string_literal: true

class RoleIcon::Component < ApplicationViewComponent
  include ActorColorsMixin

  param :role_binding

  private
    def icon
      case role_binding.role.to_sym
      when :environment_admin
        'fa-user-shield'
      when :environment_member
        'fa-user'
      when :environment_net_dev
        Network.to_icon
      when :environment_service_dev
        Service.to_icon
      when :actor_dev
        'fa-code'
      when :actor_readonly
        'fa-user-lock'
      end
    end

    def text
      [
        I18n.t("roles.#{role_binding.role}.name"),
        (" on #{role_binding.actor.name}" if role_binding.actor)
      ].join
    end

    def actor_color
      role_binding.actor&.ui_color&.to_sym
    end
end
