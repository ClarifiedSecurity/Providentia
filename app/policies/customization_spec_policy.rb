# frozen_string_literal: true

class CustomizationSpecPolicy < ApplicationPolicy
  def create?
    allowed_to?(:update?, record.virtual_machine)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def read_tags?
    create?
  end

  relation_scope do |relation|
    next relation if user.super_admin?

    relation
      .joins(:virtual_machine)
      .where(virtual_machine_id: authorized_scope(VirtualMachine.all))
  end
end
