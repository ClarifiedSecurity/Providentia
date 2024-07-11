# frozen_string_literal: true

class VersionPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  relation_scope do |relation|
    next relation if user.super_admin?
    relation.none
  end
end
