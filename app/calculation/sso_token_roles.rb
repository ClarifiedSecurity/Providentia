# frozen_string_literal: true

class SsoTokenRoles < Patterns::Calculation
  private
    def result
      return [] if !options || !Rails.configuration.oidc_authorization_roles_claim.present?
      claim = options.dig(*Rails.configuration.oidc_authorization_roles_claim)

      case claim
      when Hash, OmniAuth::AuthHash
        claim.keys
      when Array
        claim
      else
        []
      end
    end
end
