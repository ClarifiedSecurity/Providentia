# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def sso
    @user = User.from_external(
      uid: request.env['omniauth.auth'].info.nickname,
      email: request.env['omniauth.auth'].info.email,
      resources: resource_list,
      extra_fields: {
        name: request.env['omniauth.auth'].info.name
      }
    )

    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'SSO') if is_navigational_format?
    else
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end

  private
    def resource_list
      case Rails.configuration.authorization_mode
      when 'scope'
        request.env['omniauth.auth'].extra.raw_info.resources
      when 'resource_access'
        request.env['omniauth.auth'].dig(
          'extra', 'raw_info', 'resource_access',
          ENV.fetch('OIDC_CLIENT_ID', ''), 'roles'
        )
      end
    end
end
