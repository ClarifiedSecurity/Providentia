# frozen_string_literal: true

require 'rails_helper'

RSpec.describe APITokenPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { build_stubbed :api_token, user: }
  let(:context) { { user: } }

  describe_rule :index? do
    true
  end

  describe_rule :show? do
    failed
  end

  describe_rule :update? do
    failed
  end

  describe_rule :create? do
    failed
  end

  describe_rule :destroy? do
    succeed

    failed 'for another user' do
      before { record.user = build_stubbed :user }
    end
  end
end
