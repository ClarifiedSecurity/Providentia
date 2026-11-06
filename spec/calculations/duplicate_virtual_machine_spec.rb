# frozen_string_literal: true

require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.describe DuplicateVirtualMachine do
  subject(:copy) { described_class.result_for(source, name: 'copy-vm', user:) }

  let(:user) { create(:user) }
  let(:exercise) { create(:exercise) }
  let(:actor) { exercise.actors.first }
  let!(:source) {
    create(
      :virtual_machine,
      name: 'web-1', exercise:, actor:, cpu: 4, ram: 8, primary_disk_size: 60,
      description: 'desc', visibility: :actor_only
    )
  }
  let(:capability) { create(:capability, exercise:, actors: [actor]) }
  let(:same_keys) {
    %w[exercise_id actor_id operating_system_id cpu ram primary_disk_size description
       visibility deploy_mode custom_instance_count numbered_by_id numbered_by_type]
  }

  before do
    source.host_spec.update!(role_name: 'web', dns_name: 'www', tag_list: 'a, b', capabilities: [capability])
  end

  it 'copies vm fields under the new name' do
    expect(copy).to be_persisted
    expect(copy.name).to eq 'copy-vm'
    expect(copy.attributes.slice(*same_keys)).to eq source.attributes.slice(*same_keys)
    expect(copy.system_owner).to eq user
  end

  it 'fills the auto-created host spec instead of adding one' do
    expect(copy.customization_specs.mode_host.count).to eq 1
    expect(copy.host_spec.role_name).to eq 'web'
    expect(copy.host_spec.tag_list).to match_array %w[a b]
    expect(copy.host_spec.capabilities).to eq source.host_spec.capabilities
  end

  context 'with a container spec' do
    before { create(:customization_spec, virtual_machine: source, mode: 'container', name: 'side', dns_name: 'side') }

    it 'copies container specs' do
      side = copy.customization_specs.mode_container.sole
      expect(side.name).to eq 'side'
      expect(side.user).to eq user
    end

    it 'clears dns names' do
      expect(copy.customization_specs.pluck(:dns_name)).to all(be_nil)
    end
  end

  context 'addresses' do
    let(:network) { create(:network, exercise:, actor:) }
    let(:binding) { network.domain_bindings.first }
    let(:statics) { %w[ipv4_static ipv6_static] }
    let(:nic) { NetworkInterface.find_by!(virtual_machine_id: source.id) }

    before do
      pool4 = create(:address_pool, network:, network_address: '10.0.0.0/24')
      pool6 = create(:address_pool, network:, network_address: '1:a::/64', ip_family: :v6)
      create(:network_interface, network:, virtual_machine: source)
      nic.addresses.destroy_all
      create(:address, network_interface: nic, mode: :ipv4_static, address_pool: pool4, offset: '10', dns_enabled: true, connection: true,
        domain_binding: binding)
      create(:address, network_interface: nic, mode: :ipv6_static, address_pool: pool6, offset: Ipv6Offset.dump('10'))
      create(:address, network_interface: nic, mode: :ipv4_vip, address_pool: pool4, offset: '20')
      create(:address, network_interface: nic, mode: :ipv4_dhcp, offset: nil)
    end

    def signature(address)
      offset = statics.include?(address.mode) ? nil : address.offset
      [address.mode, address.address_pool_id, offset, address.dns_enabled, address.connection, address.domain_binding_id]
    end

    it 'copies the full address list, blanking static offsets' do
      expect(copy.addresses.count).to eq source.addresses.count
      expect(copy.network_interfaces.sole.addresses.map { signature(_1) }).to match_array(nic.addresses.reload.map { signature(_1) })
    end

    it 'keeps vip offsets and blanks static ones' do
      by_mode = copy.addresses.index_by(&:mode)
      expect(by_mode['ipv4_static'].offset).to be_nil
      expect(by_mode['ipv6_static'].offset).to be_nil
      expect(by_mode['ipv4_vip'].offset).to eq '20'
    end

    it 'copies dns_enabled, connection and domain binding' do
      static = copy.addresses.find_by(mode: :ipv4_static)
      expect([static.dns_enabled, static.connection, static.domain_binding_id]).to eq [true, true, binding.id]
    end

    context 'when the source nic was created with auto addresses' do
      let(:other) { create(:network, exercise:, actor:) }

      before do
        create(:address_pool, network: other, network_address: '10.1.0.0/24')
        create(:address_pool, network: other, network_address: '10.2.0.0/24')
        create(:network_interface, network: other, virtual_machine: source)
      end

      it 'copies the same number of addresses per nic' do
        expect(NetworkInterface.find_by!(network: other).addresses.count).to eq other.address_pools.count
        expect(copy.network_interfaces.order(:id).map { _1.addresses.count })
          .to eq source.network_interfaces.order(:id).map { _1.addresses.count }
        expect(copy.addresses.count).to eq source.addresses.count
      end
    end
  end

  context 'visibility' do
    it 'keeps a visibility that differs from the actor default' do
      source.update_columns(visibility: VirtualMachine.visibilities.fetch(:public))
      actor.update!(default_visibility: :actor_only)
      expect(copy.visibility).to eq 'public'
    end
  end

  context 'with a container spec that has capabilities' do
    before do
      create(:customization_spec, virtual_machine: source, mode: 'container', name: 'side', dns_name: 'side')
        .update!(capabilities: [capability])
    end

    it 'copies the capabilities' do
      expect(copy.customization_specs.mode_container.sole.capabilities).to eq [capability]
    end
  end

  context 'with a service matching on tag' do
    let(:service) { create(:service, exercise:) }
    let!(:subject_record) {
      create(:service_subject, service:, match_conditions: [
        ServiceSubjectMatchCondition.new(matcher_type: 'ActsAsTaggableOn::Tagging', matcher_id: 'a')
      ])
    }

    it 'includes the copy host spec in the cached spec ids' do
      expect(subject_record.reload.customization_spec_ids).to include(source.host_spec.id)
      expect(subject_record.reload.customization_spec_ids).not_to include(copy.host_spec.id)
      copy
      expect(subject_record.reload.customization_spec_ids).to include(copy.host_spec.id)
    end
  end

  it 'copies nics in order with egress' do
    nets = create_list(:network, 2, exercise:, actor:)
    create(:network_interface, network: nets[0], virtual_machine: source, egress: false)
    create(:network_interface, network: nets[1], virtual_machine: source, egress: true)

    expect(copy.network_interfaces.order(:id).map { [_1.network_id, _1.egress] })
      .to eq [[nets[0].id, false], [nets[1].id, true]]
  end

  context 'numbered source' do
    let(:actor) { create(:actor, :numbered, exercise:) }
    let(:network) { create(:network, exercise:, actor:) }

    before do
      source.update!(numbered_by: actor)
      create(:network_interface, network:, virtual_machine: source)
    end

    it { expect(copy).to be_persisted }
  end

  it 'does not copy instance metadata' do
    create(:instance_metadatum, customization_spec: source.host_spec)
    expect(copy.host_spec.instance_metadata).to be_empty
  end

  it 'does not copy the hostname' do
    source.update!(hostname: 'web-1-host')
    expect(copy.hostname).to be_nil
  end

  it 'rolls back everything when the name is invalid' do
    expect { described_class.result_for(source, name: 'x' * 64, user:) }
      .to raise_error(ActiveRecord::RecordInvalid)
      .and not_change(VirtualMachine, :count)
      .and not_change(CustomizationSpec, :count)
  end

  it 'rolls back the vm, specs, nics and addresses when a late step fails' do
    network = create(:network, exercise:, actor:)
    nic = create(:network_interface, network:, virtual_machine: source)
    create(:address, network_interface: nic, mode: :ipv4_dhcp, offset: nil)
    allow_any_instance_of(Address).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

    expect { described_class.result_for(source, name: 'copy-vm', user:) }
      .to raise_error(ActiveRecord::RecordInvalid)
      .and not_change(VirtualMachine, :count)
      .and not_change(CustomizationSpec, :count)
      .and not_change(NetworkInterface, :count)
      .and not_change(Address, :count)
  end
end
