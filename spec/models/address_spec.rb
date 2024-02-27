# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  context 'ip_object' do
    subject { build(:address, network:, address_pool:) }
    let(:network) { build(:network) }
    let(:address_pool) { build(:address_pool, network:, network_address:) }

    context 'ipv4' do
      context 'non-numbered net' do
        let(:network_address) { '1.0.0.0/24' }

        it 'should return first address by default' do
          expect(subject.ip_object.to_s).to eq '1.0.0.1'
        end

        it 'should generate correct sequential addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3).to_s).to eq '1.0.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3).to_s).to eq '1.0.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3).to_s).to eq '1.0.0.3'
        end

        it 'should generate correct team addresses' do
          expect(subject.ip_object(actor_number: 1).to_s).to eq '1.0.0.1'
          expect(subject.ip_object(actor_number: 2).to_s).to eq '1.0.0.2'
          expect(subject.ip_object(actor_number: 3).to_s).to eq '1.0.0.3'
        end

        it 'should generate correct sequential + team addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 1).to_s).to eq '1.0.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 1).to_s).to eq '1.0.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 1).to_s).to eq '1.0.0.3'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 2).to_s).to eq '1.0.0.4'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 2).to_s).to eq '1.0.0.5'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 2).to_s).to eq '1.0.0.6'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 3).to_s).to eq '1.0.0.7'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 3).to_s).to eq '1.0.0.8'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 3).to_s).to eq '1.0.0.9'
        end
      end

      context 'numbered net' do
        let(:network_address) { '1.{{ team_nr }}.0.0/24' }

        it 'should return first address by default' do
          expect(subject.ip_object.to_s).to eq '1.1.0.1'
        end

        it 'should generate correct sequential addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3).to_s).to eq '1.1.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3).to_s).to eq '1.1.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3).to_s).to eq '1.1.0.3'
        end

        it 'should generate correct team addresses' do
          expect(subject.ip_object(actor_number: 1).to_s).to eq '1.1.0.1'
          expect(subject.ip_object(actor_number: 2).to_s).to eq '1.2.0.1'
          expect(subject.ip_object(actor_number: 3).to_s).to eq '1.3.0.1'
        end

        it 'should generate correct sequential + team addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 1).to_s).to eq '1.1.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 1).to_s).to eq '1.1.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 1).to_s).to eq '1.1.0.3'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 2).to_s).to eq '1.2.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 2).to_s).to eq '1.2.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 2).to_s).to eq '1.2.0.3'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 3).to_s).to eq '1.3.0.1'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 3).to_s).to eq '1.3.0.2'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 3).to_s).to eq '1.3.0.3'
        end
      end
    end

    context 'ipv6' do
      subject { build(:address, network:, address_pool:, mode: :ipv6_static) }
      let(:address_pool) { build(:address_pool, network:, network_address:, ip_family: :v6) }

      context 'non-numbered net' do
        let(:network_address) { '1:a::/64' }

        it 'should return first address by default' do
          expect(subject.ip_object.to_s).to eq '1:a::'
        end

        it 'should generate correct sequential addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 15).to_s).to eq '1:a::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 15).to_s).to eq '1:a::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 15).to_s).to eq '1:a::2'
          expect(subject.ip_object(sequence_number: 15, sequence_total: 15).to_s).to eq '1:a::e'
        end

        it 'should generate correct team addresses' do
          expect(subject.ip_object(actor_number: 1).to_s).to eq '1:a::'
          expect(subject.ip_object(actor_number: 2).to_s).to eq '1:a::1'
          expect(subject.ip_object(actor_number: 3).to_s).to eq '1:a::2'
        end

        it 'should generate correct sequential + team addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 1).to_s).to eq '1:a::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 1).to_s).to eq '1:a::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 1).to_s).to eq '1:a::2'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 2).to_s).to eq '1:a::3'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 2).to_s).to eq '1:a::4'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 2).to_s).to eq '1:a::5'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 3).to_s).to eq '1:a::6'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 3).to_s).to eq '1:a::7'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 3).to_s).to eq '1:a::8'
        end
      end

      context 'numbered net' do
        let(:network_address) { '1:a:{{ team_nr }}::/64' }

        it 'should return first address by default' do
          expect(subject.ip_object.to_s).to eq '1:a:1::'
        end

        it 'should generate correct sequential addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3).to_s).to eq '1:a:1::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3).to_s).to eq '1:a:1::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3).to_s).to eq '1:a:1::2'
        end

        it 'should generate correct team addresses' do
          expect(subject.ip_object(actor_number: 1).to_s).to eq '1:a:1::'
          expect(subject.ip_object(actor_number: 2).to_s).to eq '1:a:2::'
          expect(subject.ip_object(actor_number: 3).to_s).to eq '1:a:3::'
        end

        it 'should generate correct sequential + team addresses' do
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 1).to_s).to eq '1:a:1::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 1).to_s).to eq '1:a:1::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 1).to_s).to eq '1:a:1::2'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 2).to_s).to eq '1:a:2::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 2).to_s).to eq '1:a:2::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 2).to_s).to eq '1:a:2::2'
          expect(subject.ip_object(sequence_number: 1, sequence_total: 3, actor_number: 3).to_s).to eq '1:a:3::'
          expect(subject.ip_object(sequence_number: 2, sequence_total: 3, actor_number: 3).to_s).to eq '1:a:3::1'
          expect(subject.ip_object(sequence_number: 3, sequence_total: 3, actor_number: 3).to_s).to eq '1:a:3::2'
        end
      end
    end
  end
end
