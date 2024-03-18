# frozen_string_literal: true

module API
  module V3
    class AuthinfoController < APIController
      skip_before_action :authenticate_request

      def show
        render json: {
          issuer: Rails.configuration.oidc_issuer,
          scopes: [:openid] + (Rails.configuration.authorization_mode == 'scope' ? [:resources] : [])
        }
      end
    end
  end
end