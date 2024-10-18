# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Credential, type: :model do
  let(:model) { build(:credential, name: 'John Williams') }

  context '#username' do
    subject { model.username }

    it { is_expected.to eq 'john.williams' }

    context 'with username field on config map' do
      let(:model) { build(:credential, name: 'John Williams', config_map: { username: 'bigjohn' }) }

      it { is_expected.to eq 'bigjohn' }
    end
  end

  context '#email' do
    subject { model.email }

    it { is_expected.to eq 'john.williams@' }

    context 'with username field on config map' do
      let(:model) { build(:credential, name: 'John Williams', config_map: { username: 'bigjohn' }) }

      it { is_expected.to eq 'bigjohn@' }
    end

    context 'with email field on config map' do
      let(:model) { build(:credential, name: 'John Williams', config_map: { email: 'jarjarsux' }) }

      it { is_expected.to eq 'jarjarsux@' }
    end

    context 'with email and username field on config map' do
      let(:model) { build(:credential, name: 'John Williams', config_map: { email: 'jarjarsux', username: 'bigjohn' }) }

      it { is_expected.to eq 'jarjarsux@' }
    end
  end
end
