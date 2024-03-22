# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API v3 hosts', type: :request do
  let(:exercise) { create(:exercise) }

  let!(:user) { create(:user, api_tokens: [api_token], permissions: Hash[exercise.id, ['local_admin']]) }
  let(:api_token) { create(:api_token) }
  let(:headers) { { 'Accept' => 'application/json', 'Authorization' => "Token #{api_token.token}" } }

  context 'metadata update' do
    let!(:virtual_machine) { create(:virtual_machine, exercise:, actor: exercise.actors.sample) }
    let(:presenter) { API::V3::InstancePresenter.new(virtual_machine.host_spec) }
    let(:instance_id) { presenter.send(:inventory_name) }
    let(:headers) {
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Token #{api_token.token}"
      }
    }
    let(:params) {
      {
        some: 'Variable',
        time: Time.parse('2024-03-20 14:00:00Z'),
        number: 2
      }
    }
    let(:url) { "/api/v3/#{exercise.slug}/hosts/#{virtual_machine.host_spec.slug}/instances/#{instance_id}/" }
    let(:request_method) { :put }

    subject(:do_request) {
      public_send(request_method, url, params: { metadata: params }.to_json, headers:)
    }
    subject { do_request; response }

    let!(:existing_meta) { create(:instance_metadatum, instance: instance_id, customization_spec: virtual_machine.host_spec, metadata: { 'my' => 'stuff' }) }

    context 'invalid urls - spec cannot be found' do
      let(:url) { "/api/v3/#{exercise.slug}/hosts/randomness/instances/#{instance_id}/" }

      it { is_expected.to have_http_status 404 }
    end

    context 'invalid urls - instance cannot be found' do
      let(:url) { "/api/v3/#{exercise.slug}/hosts/#{virtual_machine.host_spec.slug}/instances/randominstance/" }

      it { is_expected.to have_http_status 404 }
    end

    context 'invalid payload - empty' do
      subject { public_send(request_method, url, headers:); response }

      it { is_expected.to have_http_status 400 }
    end

    context 'invalid payload - array' do
      let(:params) { %w(asd asd2) }

      it { is_expected.to have_http_status 400 }
    end

    context 'invalid payload - string' do
      let(:params) { 'asd' }

      it { is_expected.to have_http_status 400 }
    end

    context 'invalid payload - number' do
      let(:params) { 3 }

      it { is_expected.to have_http_status 400 }
    end

    context 'Full update' do
      it { is_expected.to be_successful }

      it 'should replace previous metadata with payload' do
        subject
        expect(response.parsed_body).to have_key('result')
        expect(virtual_machine.host_spec.instance_metadata.find_by(instance: instance_id).metadata).to eq({
          'some' => 'Variable',
          'time' => '2024-03-20T14:00:00.000Z',
          'number' => 2
        })
      end

      it 'should not change timestamp of spec when updating' do
        initial_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        subject
        after_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        expect(initial_updated_at).to eq(after_updated_at)
      end
    end

    context 'Partial update' do
      let(:request_method) { :patch }

      it { is_expected.to be_successful }

      it 'should merge the payload with previous data' do
        subject
        expect(response.parsed_body).to have_key('result')
        expect(virtual_machine.host_spec.instance_metadata.find_by(instance: instance_id).metadata).to eq(
          {
            'some' => 'Variable',
            'time' => '2024-03-20T14:00:00.000Z',
            'number' => 2,
            'my' => 'stuff'
          }
        )
      end

      it 'should not change timestamp of spec when updating' do
        initial_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        subject
        after_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        expect(initial_updated_at).to eq(after_updated_at)
      end
    end

    context 'Partial update - from empty state' do
      let!(:existing_meta) { nil }
      let(:request_method) { :patch }
      it { is_expected.to be_successful }

      it 'should merge the payload with previous data' do
        subject
        expect(response.parsed_body).to have_key('result')
        expect(virtual_machine.host_spec.instance_metadata.find_by(instance: instance_id).metadata).to eq(
          {
            'some' => 'Variable',
            'time' => '2024-03-20T14:00:00.000Z',
            'number' => 2
          }
        )
      end

      it 'should not change timestamp of spec when updating' do
        initial_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        subject
        after_updated_at = CustomizationSpec.find(virtual_machine.host_spec.id).updated_at
        expect(initial_updated_at).to eq(after_updated_at)
      end
    end
  end
end
