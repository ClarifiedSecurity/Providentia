# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V3::InstancePresenter do
  let(:virtual_machine) { create(:virtual_machine) }
  let(:spec) { virtual_machine.host_spec }

  let(:actor_nr) { nil }
  let(:seq_nr) { nil }
  let(:opts) { nil }

  subject { described_class.new(spec, actor_nr, seq_nr, **opts) }

  before {
    Current.interfaces_cache ||= {}
    Current.interfaces_cache[virtual_machine.id] ||= virtual_machine.network_interfaces.for_api.load_async
  }

  context 'with include_metadata' do
    let!(:existing_meta) { create(:instance_metadatum, instance: 'doesnotmatter', customization_spec: virtual_machine.host_spec, metadata: { 'my' => 'stuff' }) }
    let(:opts) { { include_metadata: true } }

    it 'should include metadata' do
      expect(subject).to receive(:id).at_least(:once).and_return 'doesnotmatter'
      expect(subject.as_json[:metadata]).to eq({
        'my' => 'stuff'
      })
    end

    it 'should not include for mismatching instance id' do
      expect(subject.as_json[:metadata]).to eq(nil)
    end
  end
end
