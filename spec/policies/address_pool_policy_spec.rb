# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressPoolPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { build_stubbed :address_pool }
  let(:context) { { user: } }

  describe_rule :index? do
    failed
  end

  describe_rule :show? do
    failed
  end

  describe_rule :update? do
    before { expect_any_instance_of(described_class).to receive(:allowed_to?).with(:update?, record.network).and_return true }

    succeed
  end
end
