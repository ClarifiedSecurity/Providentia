# frozen_string_literal: true

class UserPermissions < Patterns::Calculation
  BASIC_ACCESS = Rails.configuration.resource_prefix + 'User'
  SUPERADMIN_ACCESS = Rails.configuration.resource_prefix + 'Super_Admin'

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
