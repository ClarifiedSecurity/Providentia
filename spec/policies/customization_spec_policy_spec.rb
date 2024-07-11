# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomizationSpecPolicy, type: :policy do
  let(:user) { create :user }
  let(:record) { create :customization_spec }
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
