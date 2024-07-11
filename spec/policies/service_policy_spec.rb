# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServicePolicy, type: :policy do
  let(:user) { create :user }
  let(:record) { build :service }
  let(:context) { { user: } }

  describe_rule :show? do
    before { expect_any_instance_of(described_class).to receive(:allowed_to?).with(:show?, record.exercise).and_return true }

    succeed
  end

  describe_rule :create? do
    context 'exercise has read-only services' do
      before { record.exercise.services_read_only = true }

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

      failed 'with environment admin role' do
        before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: record.exercise) }
      end

      succeed 'with super_admin' do
        before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
      end
    end

    context 'exercise does not have read-only services' do
      before { record.exercise.services_read_only = false }

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

      succeed 'with environment service dev role' do
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
end
