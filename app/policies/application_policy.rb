# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  pre_check :allow_admins

  def show?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end

  def update?
    true
  end

  private
    def allow_admins
      allow! if user.super_admin?
    end

    def owner?
      record.user_id == user.id
    end
end
