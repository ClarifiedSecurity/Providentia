# frozen_string_literal: true

class UserPermissions < Patterns::Calculation
  BASIC_ACCESS = Rails.configuration.resource_prefix +
    ENV.fetch('OIDC_RESOURCE_LOGIN', 'User')
  SUPERADMIN_ACCESS = Rails.configuration.resource_prefix +
    ENV.fetch('OIDC_RESOURCE_SUPERADMIN', 'Super_Admin')
  ENVIRONMENT_CREATION = Rails.configuration.resource_prefix +
    ENV.fetch('OIDC_RESOURCE_ENV_CREATOR', 'Environment_Creator')

  private
    def result
      list = subject.select do |resource|
        resource.match? resource_regex
      end
      list if list.include?(BASIC_ACCESS)
    end

    def resource_regex
      /^\/?#{Regexp.quote(Rails.configuration.resource_prefix)}/
    end
end
