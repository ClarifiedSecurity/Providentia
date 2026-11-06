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
    let(:pool4) { create(:address_pool, network:, network_address: '10.0.0.0/24') }
    let(:pool6) { create(:address_pool, network:, network_address: '1:a::/64', ip_family: :v6) }
    let(:nic) { create(:network_interface, network:, virtual_machine: source) }
    let!(:source_static) { create(:address, network_interface: nic, mode: :ipv4_static, address_pool: pool4, offset: '10') }

    before do
      create(:address, network_interface: nic, mode: :ipv6_static, address_pool: pool6, offset: Ipv6Offset.dump('10'))
      create(:address, network_interface: nic, mode: :ipv4_vip, address_pool: pool4, offset: '20')
      create(:address, network_interface: nic, mode: :ipv4_dhcp, offset: nil)
    end

    it 'blanks static offsets and keeps the rest' do
      by_mode = copy.addresses.index_by(&:mode)
      expect(by_mode['ipv4_static'].offset).to be_nil
      expect(by_mode['ipv6_static'].offset).to be_nil
      expect(by_mode['ipv4_vip'].offset).to eq '20'
      expect(by_mode.keys).to match_array %w[ipv4_static ipv6_static ipv4_vip ipv4_dhcp]
      expect(by_mode['ipv4_static'].address_pool).to eq source_static.address_pool
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

  it 'rolls back on failure' do
    nets = create(:network, exercise:, actor:)
    create(:network_interface, network: nets, virtual_machine: source)

    expect { described_class.result_for(source, name: 'x' * 64, user:) }
      .to raise_error(ActiveRecord::RecordInvalid)
      .and not_change(VirtualMachine, :count)
      .and not_change(CustomizationSpec, :count)
      .and not_change(NetworkInterface, :count)
  end
end
