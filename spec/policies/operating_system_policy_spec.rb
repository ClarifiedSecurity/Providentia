# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperatingSystemPolicy, type: :policy do
  let(:record) { build_stubbed(:operating_system) }
  let(:user) { build_stubbed(:user) }
  let(:context) { { user: } }

  describe_rule :show? do
    succeed
  end

  describe_rule :index? do
    succeed
  end

  describe_rule :update? do
    failed

    succeed 'when user is super_admin' do
      before { user.resources << UserPermissions::SUPERADMIN_ACCESS }
    end
  end
end
