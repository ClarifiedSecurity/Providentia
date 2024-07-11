# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { build_stubbed :user }
  let(:context) { { user: } }

  describe_rule :index? do
    failed
  end

  describe_rule :create? do
    failed
  end

  describe_rule :update? do
    failed
  end

  describe_rule :destroy? do
    failed
  end
end
