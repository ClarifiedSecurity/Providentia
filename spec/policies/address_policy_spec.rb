# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressPolicy, type: :policy do
  let(:exercise) { build(:exercise) }
  let(:network) { create(:network, exercise:) }
  let(:virtual_machine) { create(:virtual_machine, exercise:) }
  let(:network_interface) { create(:network_interface, network:, virtual_machine:) }
  let(:address_pool) { create(:address_pool, network:) }

  let(:user) { create :user }
  let(:record) { create :address, network_interface:, address_pool: }
  let(:context) { { user: } }

  describe_rule :index? do
    failed
  end

  describe_rule :show? do
    failed
  end

  describe_rule :create? do
    before { expect_any_instance_of(described_class).to receive(:allowed_to?).with(:update?, record.virtual_machine).and_return true }

    succeed
  end
end
