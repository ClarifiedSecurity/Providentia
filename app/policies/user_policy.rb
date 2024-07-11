# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  relation_scope do |relation|
    next relation if user.super_admin?
    relation.in_exercise(Exercise.for_user(user))
  end
end
