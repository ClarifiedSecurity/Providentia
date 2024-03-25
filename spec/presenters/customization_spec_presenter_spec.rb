# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V3::CustomizationSpecPresenter do
  subject { described_class.new(spec).as_json }
  let(:virtual_machine) { create(:virtual_machine) }
  let(:spec) { virtual_machine.host_spec }

  context 'tags' do
    it 'should contain OS and actor tags' do
      expect(subject[:tags]).to eq([
        spec.virtual_machine.operating_system.api_short_name,
        ActorAPIName.result_for(spec.virtual_machine.actor)
      ])
    end

    context 'with nested os and actor' do
      let(:virtual_machine) { create(:virtual_machine, operating_system:, actor:) }
      let(:actor) { create(:actor, parent: create(:actor)) }
      let(:operating_system) { create(:operating_system, parent: create(:operating_system)) }

      it 'should contain entire paths for both' do
        expect(subject[:tags]).to eq([
          spec.virtual_machine.operating_system.parent.api_short_name,
          spec.virtual_machine.operating_system.api_short_name,
          ActorAPIName.result_for(spec.virtual_machine.actor.parent),
          ActorAPIName.result_for(spec.virtual_machine.actor)
        ])
      end
    end
  end

  context 'clustered vm' do
    it 'return nil fields if not clustered' do
      expect(subject[:sequence_tag]).to be_nil
      expect(subject[:sequence_total]).to be_nil
    end

    context 'with custom instance count = 1' do
      let(:spec) { create(:customization_spec, virtual_machine: create(:virtual_machine, custom_instance_count: 1)) }

      it 'return nil fields' do
        expect(subject[:sequence_tag]).to eq spec.slug.to_url.tr('-', '_')
        expect(subject[:sequence_total]).to eq 1
      end
    end

    context 'with custom instance count = 2' do
      let(:spec) { create(:customization_spec, virtual_machine: create(:virtual_machine, custom_instance_count: 2)) }

      it 'return nil fields' do
        expect(subject[:sequence_tag]).to eq spec.slug.to_url.tr('-', '_')
        expect(subject[:sequence_total]).to eq 2
      end
    end
  end

  context 'options' do
    subject { described_class.new(spec, include_metadata: true) }

    it 'should include metadata in cache key' do
      expect(subject.send(:cache_key)).to include('metadata')
      expect(subject.send(:cache_key)).to include(spec.instance_metadata.cache_key_with_version)
    end

    it 'should call instance presenter with include_metadata option' do
      expect(spec).to receive(:deployable_instances).with(API::V3::InstancePresenter, include_metadata: true).and_return([])
      subject.as_json
    end
  end
end
