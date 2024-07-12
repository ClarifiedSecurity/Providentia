# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetworkPolicy, type: :policy do
  let(:user) { create :user }
  let(:record) { create :network }
  let(:context) { { user: } }

  describe_rule :index? do
    failed

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

    succeed 'with super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :show? do
    failed

    failed 'with non-related exercise access' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
    end

    context 'public' do
      before { record.visibility = :public }

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

    context 'actor_only' do
      before { record.visibility = :actor_only }

      failed 'with environment access role' do
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
  end

  describe_rule :update? do
    failed

    failed 'with non-related exercise access' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
    end

    context 'public' do
      before { record.visibility = :public }

      failed 'with environment access role' do
        before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record.exercise) }
      end

      succeed 'with environment net dev role' do
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

      failed 'with actor developer role' do
        before { create(:role_binding, user_email: user.email, role: :actor_dev, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with super_admin' do
        before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
      end
    end

    context 'actor_only' do
      before { record.visibility = :actor_only }

      failed 'with environment access role' do
        before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record.exercise) }
      end

      succeed 'with environment net dev role' do
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

      failed 'with actor developer role' do
        before { create(:role_binding, user_email: user.email, role: :actor_dev, exercise: record.exercise, actor: record.actor) }
      end

      succeed 'with super_admin' do
        before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
      end
    end
  end
end
