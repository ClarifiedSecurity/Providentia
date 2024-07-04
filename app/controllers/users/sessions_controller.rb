
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :remove_authentication_flash_message_if_root_url_requested

  private
    def remove_authentication_flash_message_if_root_url_requested
      if (session[:user_return_to] == root_path) && (flash[:alert] == I18n.t('devise.failure.unauthenticated'))
        flash.delete(:alert)
      end
    end

    def after_sign_out_path_for(_)
      '/users/auth/sso/logout'
    end
end
