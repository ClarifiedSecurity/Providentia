# frozen_string_literal: true

class APIVerifyService < Patterns::Service
  attr_reader :token_value

  def initialize(token_value)
    @token_value = token_value
  end

  def call
    return unless token_value
    payload, _header = JWT.decode token_value, public_key, true, decode_opts
    User.from_external(
      uid: payload.dig('preferred_username'),
      email: payload.dig('email'),
      resources: SsoTokenRoles.result_for(payload.to_h)
    )
  rescue JWT::DecodeError, JWT::InvalidIssuerError
  end

  private
    def public_key
      @@issuer_public_key ||= begin
        jwks = ::OpenIDConnect::Discovery::Provider::Config.discover!(Rails.configuration.oidc_issuer).jwks
        key = jwks.find { |jwk| jwk['use'] == 'sig' && jwk['alg'] == 'RS256' }
        JSON::JWK.new(key).to_key
      end
    end

    def decode_opts
      {
        verify_iss: true,
        iss: Rails.configuration.oidc_issuer,
        algorithm: 'RS256'
      }
    end
end
