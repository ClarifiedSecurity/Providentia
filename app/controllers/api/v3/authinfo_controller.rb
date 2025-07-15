# frozen_string_literal: true

module API
  module V3
    class AuthinfoController < APIController
      skip_before_action :authenticate_request

      def show
        render json: {
          issuer: Rails.configuration.oidc_issuer,
          client_id: ENV.fetch('OIDC_CLIENT_ID', ''),
          scopes: [:openid] + Rails.configuration.oidc_extra_scopes
        }
      end
    end
  end
end
