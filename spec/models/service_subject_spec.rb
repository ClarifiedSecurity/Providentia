# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceSubject do
  context 'spec cache' do
    subject { create(:service_subject, service:) }
    let(:service) { create(:service) }
    let(:virtual_machine) { create(:virtual_machine, exercise: service.exercise) }

    it 'should set correct cache when matcher condition added' do
      service.service_subjects.reload
      subject.match_conditions = [ServiceSubjectMatchCondition.new(
        matcher_type: 'CustomizationSpec', matcher_id: virtual_machine.host_spec.id
      )]
      subject.save
      subject.match_conditions[0].matcher_id = virtual_machine.host_spec.id
      subject.save
      subject.reload

      expect(subject.customization_spec_ids).to eq ([virtual_machine.host_spec.id])
    end

    context 'with a pre-existing match condition' do
      subject {
        create(:service_subject, service:, match_conditions: [ServiceSubjectMatchCondition.new(
          matcher_type: 'CustomizationSpec', matcher_id: virtual_machine.host_spec.id
        )])
      }

      let(:virtual_machine2) { create(:virtual_machine, exercise: service.exercise) }

      it 'should update cache when changing matcher id' do
        subject.match_conditions[0].matcher_id = virtual_machine2.host_spec.id
        subject.save

        expect(subject.customization_spec_ids).to eq ([virtual_machine2.host_spec.id])
      end

      it 'should update cache key for previous vms when changing matcher id' do
        subject.match_conditions[0].matcher_id = virtual_machine2.host_spec.id

        expect {
          subject.save
          virtual_machine.host_spec.reload
        }.to change(virtual_machine.host_spec, :cache_key_with_version)
      end

      it 'should update cache key for following vms when changing matcher id' do
        subject.match_conditions[0].matcher_id = virtual_machine2.host_spec.id

        expect {
          subject.save
          virtual_machine2.host_spec.reload
        }.to change(virtual_machine2.host_spec, :cache_key_with_version)
      end

      it 'should empty cached ids when deleting matcher' do
        subject.match_conditions[0].matcher_id = nil
        subject.save
        expect(subject.customization_spec_ids).to eq ([])
      end

      it 'should update cache key for previous vms when deleting matcher id' do
        subject.match_conditions[0].matcher_id = nil

        expect {
          subject.save
          virtual_machine.host_spec.reload
        }.to change(virtual_machine.host_spec, :cache_key_with_version)
      end

      it 'should update cache key for previous vms when deleting subject' do
        expect {
          subject.destroy
          virtual_machine.host_spec.reload
        }.to change(virtual_machine.host_spec, :cache_key_with_version)
      end
    end
  end

  context 'matchers' do
    subject {
      create(:service_subject, service:, match_conditions:)
    }

    let!(:service) { create(:service) }

    let(:os1) { create(:operating_system) }
    let(:os2) { create(:operating_system) }
    let(:os3) { create(:operating_system) }

    let(:actor) { create(:actor, exercise: service.exercise) }
    let(:actor3) { create(:actor, exercise: service.exercise) }

    let!(:virtual_machine1) {
      create(:virtual_machine,
        exercise: service.exercise,
        host_spec: spec1,
        actor:,
        operating_system: os1
      )
    }
    let!(:nic1) { create(:network_interface, virtual_machine: virtual_machine1, network: create(:network, exercise: service.exercise), egress: true) }
    let(:spec1) { create(:customization_spec, tag_list: 'tag1') }
    let(:capability1) { create(:capability, actors: [actor], exercise: service.exercise) }
    before { spec1.capabilities << capability1 }


    let!(:virtual_machine2) {
      create(:virtual_machine,
        exercise: service.exercise,
        host_spec: spec2,
        actor:,
        operating_system: os2
      )
    }
    let!(:nic2) { create(:network_interface, virtual_machine: virtual_machine2, network: create(:network, exercise: service.exercise), egress: true) }
    let(:spec2) { create(:customization_spec, tag_list: 'tag1') }
    before { spec2.capabilities << capability1 }

    let!(:virtual_machine3) {
      create(:virtual_machine,
        exercise: service.exercise,
        host_spec: spec3,
        actor: actor3,
        operating_system: os1
      )
    }
    let!(:nic3) { create(:network_interface, virtual_machine: virtual_machine3, network: nic1.network, egress: true) }
    let(:spec3) { create(:customization_spec, tag_list: 'tag3') }
    let(:capability3) { create(:capability, actors: [actor3], exercise: service.exercise) }
    before { spec3.capabilities << capability3 }

    let(:actor_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Actor', matcher_id: actor.id.to_s) }
    let(:actor_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Actor', matcher_id: actor3.id.to_s, invert: '1') }
    let(:spec_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'CustomizationSpec', matcher_id: spec2.id.to_s) }
    let(:spec_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'CustomizationSpec', matcher_id: spec2.id.to_s, invert: '1') }
    let(:os_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'OperatingSystem', matcher_id: os1.id.to_s) }
    let(:os_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'OperatingSystem', matcher_id: os2.id.to_s, invert: '1') }
    let(:tag_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'ActsAsTaggableOn::Tagging', matcher_id: 'tag1') }
    let(:tag_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'ActsAsTaggableOn::Tagging', matcher_id: 'tag3', invert: '1') }
    let(:network_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Network', matcher_id: nic1.network_id.to_s) }
    let(:network_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Network', matcher_id: nic2.network_id.to_s, invert: '1') }
    let(:capability_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Capability', matcher_id: capability1.id.to_s) }
    let(:capability_inverted_matcher) { ServiceSubjectMatchCondition.new(matcher_type: 'Capability', matcher_id: capability3.id.to_s, invert: '1') }

    context 'actor matcher' do
      let(:match_conditions) { [actor_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids.sort).to eq([spec1.id, spec2.id].sort)
      end
    end

    context 'inversion on actor matcher' do
      let(:match_conditions) { [[os_matcher, actor_inverted_matcher]] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end

    context 'spec matcher' do
      let(:match_conditions) { [spec_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec2.id])
      end
    end

    context 'inversion on spec matcher' do
      let(:match_conditions) { [actor_matcher, spec_inverted_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end

    context 'os matcher' do
      let(:match_conditions) { [os_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids.sort).to eq([spec1.id, spec3.id].sort)
      end
    end

    context 'inversion on os matcher' do
      let(:match_conditions) { [actor_matcher, os_inverted_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end

    context 'tag matcher' do
      let(:match_conditions) { [tag_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids.sort).to eq([spec1.id, spec2.id].sort)
      end
    end

    context 'inversion on tag matcher' do
      let(:match_conditions) { [os_matcher, tag_inverted_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end

    context 'network matcher' do
      let(:match_conditions) { [network_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids.sort).to eq([spec1.id, spec3.id].sort)
      end
    end

    context 'inversion on network matcher' do
      let(:match_conditions) { [actor_matcher, network_inverted_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end

    context 'capability matcher' do
      let(:match_conditions) { [capability_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids.sort).to eq([spec1.id, spec2.id].sort)
      end
    end

    context 'inversion on capability matcher' do
      let(:match_conditions) { [os_matcher, capability_inverted_matcher] }

      it 'should match correct vms' do
        expect(subject.matched_spec_ids).to eq([spec1.id])
      end
    end
  end
end
