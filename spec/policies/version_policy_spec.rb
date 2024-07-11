# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VersionPolicy, type: :policy do
  let(:user) { build :user }
  let(:record) { create(:exercise).versions.first }
  let(:context) { { user: } }

  describe_rule :index? do
    failed

    succeed 'when user is super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :show? do
    failed

    succeed 'when user is super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end

  describe_rule :destroy? do
    failed
  end

  describe_rule :update? do
    failed
  end
end
