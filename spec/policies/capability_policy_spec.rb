# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapabilityPolicy, type: :policy do
  let(:user) { create :user }
  let(:record) { create :capability }
  let(:context) { { user: } }

  describe_rule :show? do
    before { expect_any_instance_of(described_class).to receive(:allowed_to?).with(:show?, record.exercise).and_return true }

    succeed
  end

  describe_rule :create? do
    failed

    failed 'with non-related exercise access' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
    end

    failed 'with environment access role' do
      before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record.exercise) }
    end

    failed 'with environment net dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_net_dev, exercise: record.exercise) }
    end

    failed 'with environment service dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_service_dev, exercise: record.exercise) }
    end

    succeed 'with environment admin role' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: record.exercise) }
    end

    succeed 'with super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end
end
