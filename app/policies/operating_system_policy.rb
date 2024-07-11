# frozen_string_literal: true

class OperatingSystemPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    false
  end

  relation_scope do |relation|
    relation
  end
end
