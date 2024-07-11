# frozen_string_literal: true

class NetworkInterfacePolicy < ApplicationPolicy
  def create?
    allowed_to?(:update?, record.virtual_machine)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  relation_scope do |relation|
    next relation
  end
end
