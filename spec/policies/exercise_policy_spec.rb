# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisePolicy, type: :policy do
  let(:record) { create(:exercise) }
  let(:user) { build(:user) }
  let(:context) { { user: } }

  describe_rule :index? do
    succeed
  end

  describe_rule :show? do
    failed

    failed 'with non-related exercise access' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
    end

    succeed 'with environment access role' do
      before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record) }
    end

    succeed 'with environment net dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_net_dev, exercise: record) }
    end

    succeed 'with environment service dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_service_dev, exercise: record) }
    end

    succeed 'with environment admin role' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: record) }
    end

    succeed 'with super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :create? do
    failed

    succeed 'when user is super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :update? do
    failed

    failed 'with non-related exercise access' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: create(:exercise)) }
    end

    failed 'with environment access role' do
      before { create(:role_binding, user_email: user.email, role: :environment_member, exercise: record) }
    end

    failed 'with environment net dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_net_dev, exercise: record) }
    end

    failed 'with environment service dev role' do
      before { create(:role_binding, user_email: user.email, role: :environment_service_dev, exercise: record) }
    end

    succeed 'with environment admin role' do
      before { create(:role_binding, user_email: user.email, role: :environment_admin, exercise: record) }
    end

    succeed 'with super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :destroy? do
    failed
  end
end
