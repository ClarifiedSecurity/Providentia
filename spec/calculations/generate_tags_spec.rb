# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateTags do
  subject { described_class.result_for(source_objects) }

  context 'for Network' do
    let(:source_objects) { [network] }
    let(:network) { create(:network, domain: 'yahoo') }

    let(:default_result) {
      {
        id: network.api_short_name,
        name: network.name,
        config_map: {
          domain: network.full_domain
        },
        children: [],
        priority: 80
      }
    }

    it { is_expected.to eq([default_result]) }
  end

  context 'for OS' do
    let(:source_objects) { [operating_system] }
    let(:operating_system) { create(:operating_system) }

    let(:default_result) {
      {
        id: operating_system.api_short_name,
        name: operating_system.name,
        config_map: {},
        children: [],
        priority: 10
      }
    }

    it { is_expected.to eq([default_result]) }

    context 'with children' do
      let!(:another_os) { create(:operating_system, parent: operating_system) }

      it { is_expected.to include(default_result) }
    end

    context 'as child' do
      let!(:operating_system) { create(:operating_system, parent: create(:operating_system)) }

      it { is_expected.to include(default_result.merge(priority: 11)) }
    end
  end

  context 'for Capability' do
    let(:source_objects) { [capability] }
    let(:capability) { create(:capability, actor: build(:actor)) }

    let(:default_result) {
      {
        id: "capability_#{capability.slug}".to_url.tr('-', '_'),
        name: capability.name,
        config_map: {},
        children: [],
        priority: 20
      }
    }

    it { is_expected.to eq([default_result]) }
  end

  context 'for VM' do
    let(:source_objects) { [virtual_machine] }
    let(:virtual_machine) { create(:virtual_machine) }

    context 'which has multiple specs' do
      let!(:customization_spec) { virtual_machine.customization_specs << create(:customization_spec, virtual_machine:) }
      let!(:container_customization_spec) { virtual_machine.customization_specs << create(:customization_spec, virtual_machine:, mode: :container) }
      let(:result) {
        {
          id: "#{virtual_machine.name}_all_specs",
          name: "All specs for #{virtual_machine.name}",
          config_map: {},
          children: [],
          priority: 95
        }
      }

      it { is_expected.to include(result) }
    end

    context 'numbered by another actor' do
      let(:virtual_machine) { create(:virtual_machine, numbered_by:) }
      let(:numbered_by) { create(:actor, number: 2) }
      let(:result) {
        {
          id: ActorAPIName.result_for(virtual_machine.actor, numbered_by:),
          name: "#{virtual_machine.actor.name}, numbered by #{numbered_by.name}",
          config_map: {},
          children: [],
          priority: 32
        }
      }

      it { is_expected.to include(result) }
    end
  end

  context 'for customization specs' do
    let(:source_objects) { [customization_spec] }
    let(:customization_spec) { create(:customization_spec) }

    it { is_expected.to eq([]) }

    context 'as non-host spec' do
      let(:customization_spec) { create(:customization_spec, mode: :container) }
      let(:result) {
        [
          {
            id: 'customization_container',
            name: 'customization_container',
            config_map: {},
            children: [],
            priority: 95
          }
        ]
      }

      it { is_expected.to eq(result) }
    end

    context 'overarching group of all instances (sequential)' do
      let(:customization_spec) { create(:customization_spec, virtual_machine:) }
      let(:virtual_machine) { create(:virtual_machine, custom_instance_count: 10) }

      let(:overarching) {
        [
          {
            id: customization_spec.slug.tr('-', '_'),
            name: "All instances of #{customization_spec.slug}",
            config_map: {},
            children: [],
            priority: 90
          }
        ]
      }

      it { is_expected.to eq(overarching) }
    end

    context 'overarching group of all instances (numbered)' do
      let(:customization_spec) { create(:customization_spec, virtual_machine:) }
      let(:virtual_machine) { create(:virtual_machine, numbered_by: create(:actor, :numbered)) }

      let(:overarching) {
        [
          {
            id: customization_spec.slug.tr('-', '_'),
            name: "All instances of #{customization_spec.slug}",
            config_map: {},
            children: [],
            priority: 90
          }
        ]
      }

      it { is_expected.to eq(overarching) }
    end

    context 'custom tags' do
      let(:customization_spec) { create(:customization_spec, tag_list: 'Steinway & Sons, regular') }

      it 'should return with entry for each custom tag' do
        expect(subject.length).to eq 2
        expect(subject).to include({
          id: 'custom_steinway_and_sons',
          name: 'Custom tag steinway_and_sons',
          config_map: {},
          children: [],
          priority: 100
        })
        expect(subject).to include({
          id: 'custom_regular',
          name: 'Custom tag regular',
          config_map: {},
          children: [],
          priority: 100
        })
      end
    end
  end

  context 'for Actor' do
    let(:source_objects) { [actor] }
    let(:actor) { create(:actor) }

    let(:default_result) {
      {
        name: actor.name,
        id: ActorAPIName.result_for(actor),
        config_map: {},
        children: [],
        priority: 30
      }
    }

    it { is_expected.to eq([default_result]) }

    context 'with child actors present' do
      let!(:child_actor) { create(:actor, parent: actor) }

      it { is_expected.to eq([default_result]) }
    end

    context 'as child actor' do
      let(:actor) { create(:actor, parent: create(:actor)) }

      it { is_expected.to eq([{
          name: actor.name,
          id: ActorAPIName.result_for(actor),
          config_map: {},
          children: [],
          priority: 33
        }]) }
    end

    context 'as child actor (multiple)' do
      let(:actor) { create(:actor, parent: create(:actor, parent: create(:actor))) }

      it { is_expected.to eq([{
          name: actor.name,
          id: ActorAPIName.result_for(actor),
          config_map: {},
          children: [],
          priority: 36
        }]) }
    end

    context 'with legacy team id' do
      let(:actor) { create(:actor, abbreviation: 'gt') }

      it { is_expected.to eq([default_result, {
        id: 'team_green',
        name: 'Green',
        config_map: { team_color: 'Green' },
        children: [],
        priority: 30
      }])}
    end

    context 'if numbered' do
      let(:actor) { create(:actor, :numbered) }

      it {
        numbered_results = actor.all_numbers.map do |nr|
          {
            id: ActorAPIName.result_for(actor, number: nr),
            name: "#{actor.name} number #{nr}",
            children: [],
            config_map: {},
            priority: 31
          }
        end
        is_expected.to eq([default_result] + numbered_results)
      }

      context 'actor numbered config exists' do
        before { actor.save }
        before { create(:actor_number_config, actor:, matcher: [1], config_map: { hello: 'world' }) }

        it 'should contain the config map in numbered group' do
          expect(subject).to include({
            id: ActorAPIName.result_for(actor, number: 1),
            name: "#{actor.name} number 1",
            children: [],
            config_map: {
              'hello' => 'world'
            },
            priority: 31
          })
        end

        it 'should merge configs, if multiple are present' do
          create(:actor_number_config, actor:, matcher: [1], config_map: { another: 'one' })
          expect(subject).to include({
            id: ActorAPIName.result_for(actor, number: 1),
            name: "#{actor.name} number 1",
            children: [],
            config_map: {
              'hello' => 'world',
              'another' => 'one'
            },
            priority: 31
          })
        end
      end

      context 'if called with spec parameter' do
        subject { described_class.result_for(source_objects, spec: 'anything') }

        it { is_expected.to eq([default_result]) }
      end

      context 'with number configs' do
        let!(:config) {
          create(:actor_number_config,
            actor:,
            matcher: actor.all_numbers.take(2),
            config_map: { special: true }
          )
        }

        let!(:config2) {
          create(:actor_number_config,
            actor:,
            matcher: actor.all_numbers.take(2),
            config_map: { really_special: false }
          )
        }

        let(:numbered_results) {
          actor.all_numbers.map do |nr|
            map = config.config_map.merge(config2.config_map) if config.matcher.include?(nr.to_s)
            {
              id: ActorAPIName.result_for(actor, number: nr),
              name: "#{actor.name} number #{nr}",
              children: [],
              config_map: map || {},
              priority: 31
            }
          end
        }

        it { is_expected.to include(default_result) }
        it { is_expected.to include(*numbered_results) }
      end

      context 'when nested' do
        let(:actor) { create(:actor, parent: create(:actor, :numbered)) }

        it {
          numbered_results = actor.parent.all_numbers.map do |nr|
            {
              id: ActorAPIName.result_for(actor, number: nr),
              name: "#{actor.name} number #{nr}",
              children: [],
              config_map: {},
              priority: 34
            }
          end
          is_expected.to eq([default_result.merge(priority: 33)] + numbered_results)
        }
      end
    end

    context 'as numbered actor for VM-s' do
      let(:actor) { create(:actor, :numbered) }
      let(:vm_primary_actor) { create(:actor, name: 'Primary', abbreviation: 'pr') }
      let!(:numbered_vms) {
        create_list(:virtual_machine, 2, actor: vm_primary_actor, numbered_by: actor)
      }

      let(:main_result) {
        {
          id: ActorAPIName.result_for(vm_primary_actor, numbered_by: actor),
          name: "#{vm_primary_actor.name}, numbered by #{actor.name}",
          config_map: {},
          children: [],
          priority: 32
        }
      }
      let(:numbered_results) {
        actor.all_numbers.map do |nr|
          {
            id: ActorAPIName.result_for(vm_primary_actor, numbered_by: actor, number: nr),
            name: "#{vm_primary_actor.name}, numbered by #{actor.name} - number #{nr}",
            config_map: {},
            children: [],
            priority: 32
          }
        end
      }

      it { is_expected.to include(main_result) }
      it { is_expected.to include(*numbered_results) }

      context 'if not numbered' do
        let(:actor) { create(:actor) }

        pending
      end

      context 'if called with spec parameter' do
        subject { described_class.result_for(source_objects, spec: 'anything') }

        it { is_expected.to eq([default_result]) }
      end

      context 'with VM actor as subactor' do
        let(:parent_actor) { create(:actor, name: 'ParentOfPrimary', abbreviation: 'par') }
        let(:vm_primary_actor) { create(:actor, name: 'Primary', abbreviation: 'pr', parent: parent_actor) }

        let(:main_result) {
          {
            id: ActorAPIName.result_for(vm_primary_actor, numbered_by: actor),
            name: "#{vm_primary_actor.name}, numbered by #{actor.name}",
            config_map: {},
            children: [],
            priority: 35
          }
        }

        let(:numbered_results) {
          actor.all_numbers.map do |nr|
            {
              id: ActorAPIName.result_for(vm_primary_actor, numbered_by: actor, number: nr),
              name: "#{vm_primary_actor.name}, numbered by #{actor.name} - number #{nr}",
              config_map: {},
              children: [],
              priority: 35
            }
          end
        }

        it { is_expected.to include(main_result) }
        it { is_expected.to include(*numbered_results) }
      end

      context 'with VM actor as subactor of numbered actor' do
        let(:vm_primary_actor) { create(:actor, name: 'Primary', abbreviation: 'pr', parent: actor) }

        let(:main_result) {
          {
            id: ActorAPIName.result_for(actor),
            name: actor.name,
            config_map: {},
            children: [],
            priority: 30
          }
        }

        let(:numbered_results) {
          actor.all_numbers.map do |nr|
            {
              id: ActorAPIName.result_for(actor, number: nr),
              name: "#{actor.name} number #{nr}",
              config_map: {},
              children: [],
              priority: 31
            }
          end
        }

        it { is_expected.to eq([main_result] + numbered_results) }
      end

      context 'with numbered configs' do
        let!(:config) {
          create(:actor_number_config,
            actor:,
            matcher: actor.all_numbers.take(2),
            config_map: { special: true }
          )
        }

        let!(:config2) {
          create(:actor_number_config,
            actor:,
            matcher: actor.all_numbers.take(2),
            config_map: { really_special: false }
          )
        }

        let(:numbered_results) {
          actor.all_numbers.map do |nr|
            map = config.config_map.merge(config2.config_map) if config.matcher.include?(nr.to_s)

            {
              id: ActorAPIName.result_for(vm_primary_actor, numbered_by: actor, number: nr),
              name: "#{vm_primary_actor.name}, numbered by #{actor.name} - number #{nr}",
              children: [],
              config_map: map || {},
              priority: 32
            }
          end
        }

        it { is_expected.to include(main_result) }
        it { is_expected.to include(*numbered_results) }
      end
    end
  end

  context 'for InstancePresenter' do
    let(:source_objects) { [presenter] }
    let(:presenter) { API::V3::InstancePresenter.new(customization_spec) }
    let(:customization_spec) { create(:customization_spec) }

    it { is_expected.to eq([]) }

    context 'with numbered spec and team number' do
      let(:numbered_actor) { create(:actor, number: 3) }
      let(:vm) { create(:virtual_machine, numbered_by: numbered_actor) }
      let(:customization_spec) { create(:customization_spec, virtual_machine: vm) }
      let(:presenter) { API::V3::InstancePresenter.new(customization_spec, nil, 1) }

      let(:result) {
        {
          id: ActorAPIName.result_for(vm.actor, number: 1, numbered_by: numbered_actor),
          name: "#{vm.actor.name}, numbered by #{numbered_actor.name} - number 1",
          children: [],
          config_map: {},
          priority: 32
        }
      }

      it { is_expected.to eq([result]) }

      context 'if numbered within subtree of vm actor' do
        let(:root_actor) { create(:actor) }
        let(:actor) { create(:actor, number: 3, parent: root_actor) }
        let(:vm) { create(:virtual_machine, numbered_by: root_actor, actor:) }

        let(:result) {
          {
            id: ActorAPIName.result_for(actor, number: 1),
            name: "#{actor.name} number 1",
            children: [],
            config_map: {},
            priority: 34
          }
        }

        let(:root_result) {
          {
            id: ActorAPIName.result_for(root_actor, number: 1),
            name: "#{root_actor.name} number 1",
            children: [],
            config_map: {},
            priority: 31
          }
        }

        it { is_expected.to include(root_result) }
        it { is_expected.to include(result) }
      end
    end
  end
end
