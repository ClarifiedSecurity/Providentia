# frozen_string_literal: true

class ActorNumberConfigPolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    can_read_exercise?
  end

  def create?
    can_edit_exercise?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  relation_scope do |relation|
    # next relation if user.admin?
    # relation.where(user: user)
    next relation
  end

  private
    def can_edit_exercise?
      allowed_to?(:update?, record.exercise)
    end

    def can_read_exercise?
      allowed_to?(:show?, record.exercise)
    end
end
