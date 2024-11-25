# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateTags do
  context 'tag_sources' do
    subject(:instance) { described_class.new(inputs) }
    subject { instance.cached_result; instance.tag_sources }
    let(:inputs) { }

    it { is_expected.to eq(Set.new) }

    context 'multiple of unsupported input' do
      let(:inputs) { [2, 2] }

      it { is_expected.to eq(Set.new) }
    end

    context 'multiple of supported input' do
      let(:operating_system) { create(:operating_system) }
      let(:inputs) { [operating_system, operating_system] }

      it { is_expected.to eq(Set.new([operating_system])) }
    end

    context 'spec presenter input' do
      let(:vm) { create(:virtual_machine) }
      let(:inputs) { API::V3::CustomizationSpecPresenter.new(vm.host_spec) }

      it 'should populate sources with multiple associated objects' do
        expect(subject).to eq(
          Set.new([
            vm.operating_system,
            vm.actor
          ])
        )
      end

      context 'with two vms using same OS and actor' do
        let(:vm) { create(:virtual_machine, custom_instance_count: 2) }
        let(:vm2) { create(:virtual_machine, operating_system: vm.operating_system, actor: vm.actor, custom_instance_count: 2) }
        let(:inputs) { [API::V3::CustomizationSpecPresenter.new(vm.host_spec), API::V3::CustomizationSpecPresenter.new(vm2.host_spec)] }

        it 'should populate sources with multiple associated objects, no duplicates' do
          expect(subject).to eq(
            Set.new([
              vm.operating_system,
              vm.actor,
              described_class::MultiContainer.new(vm.host_spec),
              described_class::MultiContainer.new(vm2.host_spec)
            ])
          )
        end
      end

      context 'with connection NIC' do
        let(:network) { create(:network, exercise: vm.exercise) }
        let(:address_pool) { create(:address_pool, network:) }
        let(:nic) { create(:network_interface, network:, virtual_machine: vm) }
        let!(:address) { create(:address, network_interface: nic, connection: true, address_pool:) }

        it 'should populate sources with multiple associated objects' do
          expect(nic.id).to eq(vm.connection_nic.id)
          expect(subject).to eq(
            Set.new([
              vm.operating_system,
              vm.actor,
              network
            ])
          )
        end
      end

      context 'with capability on spec' do
        let!(:capability) { create(:capability, customization_specs: [vm.host_spec]) }

        it 'should populate sources with multiple associated objects' do
          expect(subject).to eq(
            Set.new([
              vm.operating_system,
              vm.actor,
              capability
            ])
          )
        end
      end

      context 'with parent OS and parent actor' do
        let(:parent_os) { create(:operating_system) }
        let(:parent_actor) { create(:actor) }

        before do
          vm.operating_system.update(parent: parent_os)
          vm.actor.update(parent: parent_actor)
        end

        it 'should populate sources with multiple associated objects' do
          expect(subject).to eq(
            Set.new([
              vm.operating_system,
              vm.actor,
              parent_actor,
              parent_os
            ])
          )
        end
      end
    end
  end

  context 'transformation' do
    subject { described_class.result_for(input) }
    let(:input) { }

    let(:expected_id) { }
    let(:expected_name) { }
    let(:expected_priority) { }
    let(:expected_config_map) { {} }
    let(:expected_tag) {
      described_class::ApiTag.new(
        id: expected_id,
        name: expected_name,
        config_map: expected_config_map,
        priority: expected_priority
      )
    }

    it { is_expected.to eq([]) }

    context 'operatingsystem' do
      let(:input) { create(:operating_system) }
      let(:expected_id) { input.api_short_name }
      let(:expected_name) { input.name }
      let(:expected_priority) { 10 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'nested operatingsystem' do
      let(:input) { create(:operating_system, parent: create(:operating_system)) }
      let(:expected_id) { input.api_short_name }
      let(:expected_name) { input.name }
      let(:expected_priority) { 11 }

      it { is_expected.to eq([
        described_class::ApiTag.new(id: input.parent.api_short_name, name: input.parent.name, priority: 10),
        expected_tag
      ]) }
    end

    context 'capability' do
      let(:input) { create(:capability, name: 'UMBRELLA & SONS') }
      let(:expected_id) { 'capability_umbrella_sons' }
      let(:expected_name) { 'UMBRELLA & SONS' }
      let(:expected_priority) { 20 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'actor' do
      let(:input) { create(:actor) }
      let(:expected_id) { ActorAPIName.result_for(input) }
      let(:expected_name) { input.name }
      let(:expected_priority) { 30 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'nested actor' do
      let(:input) { create(:actor, parent: create(:actor)) }
      let(:expected_id) { ActorAPIName.result_for(input) }
      let(:expected_name) { input.name }
      let(:expected_priority) { 31 }

      it { is_expected.to eq([
        described_class::ApiTag.new(
          id: ActorAPIName.result_for(input.parent),
          name: input.parent.name,
          priority: 30
        ), expected_tag]) }
    end

    context 'numbered by another actor (same subtree)' do
      let(:numbered_by) { create(:actor, number: 2) }
      let(:actor) { create(:actor, parent: numbered_by) }
      let(:input) { create(:virtual_machine, actor:, numbered_by:) }

      it { is_expected.to eq([]) }
    end

    context 'numbered by another actor (different subtree)' do
      let(:numbered_by) { create(:actor, number: 2) }
      let(:actor) { create(:actor) }
      let(:input) { create(:virtual_machine, actor:, numbered_by:) }

      let(:expected_id) { ActorAPIName.result_for(actor, numbered_by:) }
      let(:expected_name) { "#{actor.name}, numbered by #{numbered_by.name}" }
      let(:expected_priority) { 32 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'nested actor, numbered by another actor (different subtree)' do
      let(:numbered_by) { create(:actor, number: 2) }
      let(:actor) { create(:actor, parent: create(:actor)) }
      let(:input) { create(:virtual_machine, actor:, numbered_by:) }

      let(:expected_id) { ActorAPIName.result_for(actor, numbered_by:) }
      let(:expected_name) { "#{actor.name}, numbered by #{numbered_by.name}" }
      let(:expected_priority) { 35 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'network' do
      let(:input) { create(:network) }
      let(:expected_id) { input.api_short_name }
      let(:expected_name) { input.name }
      let(:expected_config_map) { { domain: input.full_domain } }
      let(:expected_priority) { 80 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'instance presenter' do
      let(:input) { API::V3::InstancePresenter.new(vm.host_spec) }
      let(:vm) { create(:virtual_machine) }

      it { is_expected.to eq([]) }

      context 'with team number and numbered spec (same subtree)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let(:vm) { create(:virtual_machine, actor: numbered_by, numbered_by:) }
        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        let(:expected_id) { ActorAPIName.result_for(numbered_by, number: 1) }
        let(:expected_name) { "#{numbered_by.name} number 1" }
        let(:expected_priority) { 31 }

        it { is_expected.to eq([expected_tag]) }
      end

      context 'with team number and numbered spec (same subtree, nested)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let(:vm) { create(:virtual_machine, actor: create(:actor, parent: numbered_by), numbered_by:) }
        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        it { is_expected.to eq([
          described_class::ApiTag.new(id: ActorAPIName.result_for(vm.actor.parent, number: 1), name: "#{vm.actor.parent.name} number 1", priority: 31),
          described_class::ApiTag.new(id: ActorAPIName.result_for(vm.actor, number: 1), name: "#{vm.actor.name} number 1", priority: 34)
        ]) }
      end

      context 'with team number and numbered spec (same subtree, config present)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let!(:config) { create(:actor_number_config, actor: numbered_by, matcher: [1], config_map: { hello: 'world' }) }
        let(:vm) { create(:virtual_machine, actor: numbered_by, numbered_by:) }

        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        let(:expected_id) { ActorAPIName.result_for(numbered_by, number: 1) }
        let(:expected_name) { "#{numbered_by.name} number 1" }
        let(:expected_config_map) { { 'hello' => 'world' } }
        let(:expected_priority) { 31 }

        it { is_expected.to eq([expected_tag]) }
      end

      context 'with team number and numbered spec (same subtree, config on non-matching number)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let!(:config) { create(:actor_number_config, actor: numbered_by, matcher: [2], config_map: { hello: 'world' }) }
        let(:vm) { create(:virtual_machine, actor: numbered_by, numbered_by:) }

        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        let(:expected_id) { ActorAPIName.result_for(numbered_by, number: 1) }
        let(:expected_name) { "#{numbered_by.name} number 1" }
        let(:expected_priority) { 31 }

        it { is_expected.to eq([expected_tag]) }
      end

      context 'with team number and numbered spec (same subtree, multiple configs)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let!(:config) { create(:actor_number_config, actor: numbered_by, matcher: [1], config_map: { hello: 'world' }) }
        let!(:config2) { create(:actor_number_config, actor: numbered_by, matcher: [1], config_map: { another: 'one' }) }
        let(:vm) { create(:virtual_machine, actor: numbered_by, numbered_by:) }

        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        let(:expected_id) { ActorAPIName.result_for(numbered_by, number: 1) }
        let(:expected_name) { "#{numbered_by.name} number 1" }
        let(:expected_config_map) { { 'hello' => 'world', 'another' => 'one' } }
        let(:expected_priority) { 31 }

        it { is_expected.to eq([expected_tag]) }
      end

      context 'with team number and numbered spec (different subtree)' do
        let(:numbered_by) { create(:actor, number: 3) }
        let(:vm) { create(:virtual_machine, numbered_by:) }
        let(:input) { API::V3::InstancePresenter.new(vm.host_spec, nil, 1) }

        let(:expected_id) { ActorAPIName.result_for(vm.actor, number: 1, numbered_by:) }
        let(:expected_name) { "#{vm.actor.name}, numbered by #{numbered_by.name} - number 1" }
        let(:expected_priority) { 32 }

        it { is_expected.to eq([expected_tag]) }
      end
    end

    context 'customization spec (clustered, host)' do
      let(:input) { create(:customization_spec, virtual_machine: create(:virtual_machine, custom_instance_count: 2)) }

      let(:expected_id) { input.slug.tr('-', '_') }
      let(:expected_name) { "All instances of #{input.slug}" }
      let(:expected_priority) { 90 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'customization spec (clustered, container, clustered)' do
      let(:input) { create(:customization_spec, virtual_machine: create(:virtual_machine, custom_instance_count: 2), cluster_mode: true, mode: :container) }

      let(:expected_id) { input.slug.tr('-', '_') }
      let(:expected_name) { "All instances of #{input.slug}" }
      let(:expected_priority) { 90 }

      it { is_expected.to include(expected_tag) }
    end

    context 'customization spec (clustered, not cluster mode)' do
      let(:input) { create(:customization_spec, virtual_machine: create(:virtual_machine, custom_instance_count: 2), cluster_mode: false, mode: :container) }

      let(:expected_id) { input.slug.tr('-', '_') }
      let(:expected_name) { "All instances of #{input.slug}" }
      let(:expected_priority) { 90 }

      it { is_expected.to_not include(expected_tag) }
    end

    context 'customization spec (numbered by actor)' do
      let(:actor) { create(:actor, :numbered) }
      let(:virtual_machine) { create(:virtual_machine, actor:, numbered_by: actor) }
      let(:input) { create(:customization_spec, virtual_machine:) }

      let(:expected_id) { input.slug.tr('-', '_') }
      let(:expected_name) { "All instances of #{input.slug}" }
      let(:expected_priority) { 90 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'customization spec (container mode)' do
      let(:input) { create(:customization_spec, mode: :container) }

      let(:expected_id) { 'customization_container' }
      let(:expected_name) { 'customization_container' }
      let(:expected_priority) { 95 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'virtualmachine (multiple specs)' do
      let(:input) { create(:virtual_machine, customization_specs: [create(:customization_spec), create(:customization_spec, mode: :container)]) }

      let(:expected_id) { "#{input.name.tr('-', '_')}_all_specs" }
      let(:expected_name) { "All specs for #{input.name}" }
      let(:expected_priority) { 95 }

      it { is_expected.to eq([expected_tag]) }
    end

    context 'customizationspec (tags)' do
      let(:input) { create(:customization_spec, tag_list: 'some,tags,here') }
      before { Current.user = build(:user) }

      context 'with admin permissions' do
        let!(:binding) { create(:role_binding, user_email: Current.user.email, role: :environment_admin, exercise: input.exercise) }

        it { is_expected.to eq([
          described_class::ApiTag.new(id: 'custom_some', name: 'Custom tag some', priority: 100),
          described_class::ApiTag.new(id: 'custom_tags', name: 'Custom tag tags', priority: 100),
          described_class::ApiTag.new(id: 'custom_here', name: 'Custom tag here', priority: 100)
        ]) }
      end

      context 'with read-only user' do
        let!(:binding) { create(:role_binding, user_email: Current.user.email, role: :environment_member, exercise: input.exercise) }

        it { is_expected.to eq([]) }
      end
    end
  end
end
