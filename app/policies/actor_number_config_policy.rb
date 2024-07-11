# frozen_string_literal: true

class ActorNumberConfigPolicy < ApplicationPolicy
  include EnvironmentAssociatedPolicy

  def index?
    show?
  end

  def show?
    can_read_exercise?
  end

  def create?
    false
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    next relation
  end
end
