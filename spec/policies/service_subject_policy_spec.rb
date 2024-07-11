# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceSubjectPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { build_stubbed :service_subject }
  let(:context) { { user: } }

  describe_rule :index? do
    failed
  end

  describe_rule :show? do
    failed
  end

  describe_rule :create? do
    before { expect_any_instance_of(described_class).to receive(:allowed_to?).with(:update?, record.service).and_return true }

    succeed
  end
end
