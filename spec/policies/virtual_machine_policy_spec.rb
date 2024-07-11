# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VirtualMachinePolicy, type: :policy do
  let(:user) { create :user }
  let(:record) { create :virtual_machine }
  let(:context) { { user: } }

  describe_rule :index? do
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

    failed 'with actor member role' do
      before { create(:role_binding, user_email: user.email, role: :actor_readonly, exercise: record.exercise, actor: record.actor) }
    end

    succeed 'with actor developer role' do
      before { create(:role_binding, user_email: user.email, role: :actor_dev, exercise: record.exercise, actor: record.actor) }
    end

    succeed 'with super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :show? do
    failed

    context 'with visibility public' do
      before { record.visibility = :public }

      failed 'with non-related exercise access' do
        before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
      end

      succeed 'with environment access role' do
        before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record.exercise) }
      end

      succeed 'with environment net dev role' do
        before { create(:role_binding, user_email: user.email, role: :environment_net_dev, exercise: record.exercise) }
      end

      succeed 'with environment service dev role' do
        before { create(:role_binding, user_email: user.email, role: :environment_service_dev, exercise: record.exercise) }
      end

      succeed 'with environment admin role' do
        before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: record.exercise) }
      end

      succeed 'with actor member role' do
        before { create(:role_binding, user_email: user.email, role: :actor_readonly, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with actor developer role' do
        before { create(:role_binding, user_email: user.email, role: :actor_dev, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with super_admin' do
        before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
      end
    end

    context 'with visibility public' do
      before { record.visibility = :actor_only }

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

      succeed 'with actor member role' do
        before { create(:role_binding, user_email: user.email, role: :actor_readonly, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with actor developer role' do
        before { create(:role_binding, user_email: user.email, role: :actor_dev, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with super_admin' do
        before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
      end
    end
  end
end
