# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetworkAddressNormalizer do
  subject { described_class.result_for(address_pool) }
  let(:address_pool) { build(:address_pool, network_address:, ip_family:) }

  context 'with blank address' do
    let(:ip_family) { :v4 }
    let(:network_address) { '' }

    it { is_expected.to eq '' }
  end

  context 'is IPv4' do
    let(:ip_family) { :v4 }

    context 'equals net address' do
      let(:network_address) { '192.168.1.0/24' }

      it { is_expected.to eq '192.168.1.0/24' }
    end

    context 'equals host address' do
      let(:network_address) { '192.168.1.3/24' }

      it { is_expected.to eq '192.168.1.0/24' }
    end

    context 'equals broadcast address' do
      let(:network_address) { '192.168.1.255/24' }

      it { is_expected.to eq '192.168.1.0/24' }
    end

    context 'equals overspecific address' do
      let(:network_address) { '192.168.1.0/16' }

      it { is_expected.to eq '192.168.0.0/16' }
    end

    context 'equals overspecific address on non-octet boundary' do
      let(:network_address) { '192.168.92.0/18' }

      it { is_expected.to eq '192.168.64.0/18' }
    end

    context 'equals address with templating at last octet' do
      let(:network_address) { '192.168.1.{{ team_nr }}/16' }

      it { is_expected.to eq '192.168.0.{{ team_nr }}/16' }
    end

    context 'equals address with templating without clashing with subnet' do
      let(:network_address) { '10.{{ team_nr }}.1.100/24' }

      it { is_expected.to eq '10.{{ team_nr }}.1.0/24' }
    end

    context 'equals address with templating and clashing with subnet' do
      let(:network_address) { '10.10.{{ team_nr }}.100/17' }

      it { is_expected.to eq '10.10.{{ team_nr }}.0/17' }
    end
  end

  context 'is IPv6' do
    let(:ip_family) { :v6 }

    context 'equals net address' do
      let(:network_address) { '2001:db8::/32' }

      it { is_expected.to eq '2001:db8::/32' }
    end

    context 'equals host address' do
      let(:network_address) { '2001:db8::1/32' }

      it { is_expected.to eq '2001:db8::/32' }
    end

    context 'equals overspecific address' do
      let(:network_address) { '2001:db8:abcd::/32' }

      it { is_expected.to eq '2001:db8::/32' }
    end

    context 'equals overspecific address on nibble boundary' do
      let(:network_address) { '2001:db8:abcd:ef01:2345:6789:abcd:ef01/60' }

      it { is_expected.to eq '2001:db8:abcd:ef00::/60' }
    end

    context 'equals net address with templating in host section' do
      let(:network_address) { '2001:db8:abcd:ef01:2345:6789:abcd:{{ team_nr }}/64' }

      it { is_expected.to eq '2001:db8:abcd:ef01::{{ team_nr }}/64' }
    end

    context 'equals net address with templating in subnet section' do
      let(:network_address) { '2001:db8:{{ team_nr }}:ef01:2345:6789:abcd:0/64' }

      it { is_expected.to eq '2001:db8:{{ team_nr }}:ef01::/64' }
    end

    context 'equals net address with templating in subnet section, compressed form' do
      let(:network_address) { '2001:db8:{{ team_nr }}:abc::/64' }

      it { is_expected.to eq '2001:db8:{{ team_nr }}:abc::/64' }
    end

    context 'equals net address with templating in host section, compressed form' do
      let(:network_address) { '2001:db8::{{ team_nr }}/64' }

      it { is_expected.to eq '2001:db8::{{ team_nr }}/64' }
    end
  end
end
