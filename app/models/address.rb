# frozen_string_literal: true

class Address < ApplicationRecord
  has_paper_trail

  belongs_to :network_interface, touch: true
  belongs_to :address_pool, touch: true, optional: true
  has_one :virtual_machine, through: :network_interface
  has_one :network, through: :network_interface
  has_one :actor, through: :network

  delegate :exercise, to: :network

  enum :mode, {
    ipv4_static: 1,
    ipv4_dhcp: 2,
    ipv6_static: 3,
    ipv6_slaac: 4,
    ipv6_dhcp: 5,
    ipv6_linklocal: 6,
    ipv6_uniqlocal: 7,
    ipv4_vip: 8,
    ipv6_vip: 9
  }, prefix: :mode, default: 'ipv4_static'

  scope :all_ip_objects, -> {
    includes(:virtual_machine, :network)
      .flat_map(&:all_ip_objects)
      .compact
  }

  scope :for_api, -> {
    where(mode: %i(ipv4_dhcp ipv6_dhcp ipv6_slaac))
      .or(where.not(offset: nil))
  }

  scope :for_search, -> {
    where(mode: %i(ipv4_static ipv4_vip ipv6_static ipv6_linklocal ipv6_uniqlocal ipv6_vip))
    includes(:network)
    .where.not(offset: nil)
    .order(%i(mode offset))
    .limit(4)
  }

  scope :gateway, -> {
    joins(:address_pool)
      .where(mode: %w(ipv4_static ipv4_vip ipv6_static ipv6_vip))
      .where('addresses.offset = address_pools.gateway::varchar')
  }

  before_validation :clear_on_mode_change,
    :clear_offset, :set_to_connection_if_first_address,
    on: :update
  before_validation :set_default_mode, :populate_first_pool_if_empty
  after_save :fix_connection_flag

  validate :check_ip_offset6, :check_ip_offset4, :check_overlap

  def self.to_icon
    'fa-id-badge'
  end

  def ip_family
    if ipv4?
      :ipv4
    elsif ipv6?
      :ipv6
    end
  end

  def ip_family_network(team = nil)
    case mode
    when 'ipv4_static', 'ipv4_vip', 'ipv6_static', 'ipv6_vip'
      address_pool.ip_network(team)
    when 'ipv6_linklocal'
      IPAddress::IPv6.new('fe80::/10')
    when 'ipv6_uniqlocal'
      IPAddress::IPv6.new('fc00::/7')
    end
  end

  def ip_family_network_template
    case mode
    when 'ipv4_static', 'ipv4_vip', 'ipv6_static', 'ipv6_vip'
      address_pool.network_address
    when 'ipv6_linklocal'
      'fe80::/64'
    when 'ipv6_uniqlocal'
      'fc00::/7'
    end
  end

  def ip_object(sequence_number: nil, sequence_total: nil, actor_number: nil)
    return unless fixed? && ip_family_network_template.present?
    static_offset = offset.to_i
    static_offset -= 1 if ipv6?
    static_offset += (sequence_number || 1) - 1 unless vip?
    static_offset += ((actor_number || 1) - 1) * (sequence_total || 1) if !address_pool&.numbered?

    ip_family_network(actor_number).allocate(static_offset)
  end

  def ipv4?
    mode_ipv4_static? || mode_ipv4_dhcp? || mode_ipv4_vip?
  end

  def ipv6?
    mode_ipv6_static? || mode_ipv6_slaac? || mode_ipv6_dhcp? || mode_ipv6_linklocal? || mode_ipv6_uniqlocal? || mode_ipv6_vip?
  end

  def vip?
    mode_ipv4_vip? || mode_ipv6_vip?
  end

  def fixed?
    mode_ipv4_static? || mode_ipv6_static? || mode_ipv6_linklocal? || mode_ipv6_uniqlocal? || vip?
  end

  def needs_pool?
    mode_ipv4_static? || mode_ipv6_static? || vip?
  end

  def all_ip_objects
    return unless offset

    virtual_machine.deployable_instances.map do |(actor_number, sequence_number)|
      ip_object(sequence_number:, actor_number:, sequence_total: virtual_machine.custom_instance_count)
    end
  end

  private
    def check_overlap
      return unless offset && !vip?
      errors.add(:offset, :overlap) if (other_used_addresses & all_ip_objects).any?
    rescue StopIteration
      errors.add(:offset, :invalid_overlap)
    end

    def other_used_addresses
      (needs_pool? ? address_pool.addresses : network.addresses)
        .where.not(id:)
        .where(mode: self.mode)
        .all_ip_objects
    end

    def check_ip_offset4
      return unless mode_ipv4_static? && offset

      address = ip_family_network.allocate(offset.to_i)
      errors.add(:offset, :invalid) unless address_pool.available_range.include?(address)
    rescue StopIteration
      self.offset = self.offset_was
      errors.add(:offset, :invalid_offset4)
    end

    def check_ip_offset6
      return unless fixed? && ipv6? && offset
      ip_family_network.allocate(offset.to_i - 1)
    rescue StopIteration
      self.offset = self.offset_was
      errors.add(:offset, :invalid_offset6)
    end

    def clear_on_mode_change
      return unless mode_changed?
      self.address_pool = nil
      self.connection = false
      self.dns_enabled = false if fixed?
      true
    end

    def set_default_mode
      return if network.address_pools.ip_v4.any?
      self.mode ||= :ipv4_dhcp
    end

    def populate_first_pool_if_empty
      return unless mode_ipv4_static? || mode_ipv4_vip? || mode_ipv6_static? || mode_ipv6_vip?
      return if address_pool

      if ipv4?
        self.address_pool = network.address_pools.ip_v4.first
      else
        self.address_pool = network.address_pools.ip_v6.first
      end
    end

    def clear_offset
      return unless mode_changed?
      self.offset = nil
      true
    end

    def set_to_connection_if_first_address
      self.connection = true if virtual_machine.addresses.empty?
      true
    end

    def fix_connection_flag
      return if id_previously_changed? || !connection_previously_changed?
      if connection
        virtual_machine.addresses.where.not(id: self.id).update_all(connection: false)
      else
        (first_mgmt_address || first_egress_address).update_column(:connection, true)
      end
    end

    def first_mgmt_address
      virtual_machine.addresses.joins(:address_pool).merge(AddressPool.scope_mgmt).order(:ip_family).first
    end

    def first_egress_address
      virtual_machine.addresses.joins(:network_interface).where(network_interfaces: { egress: true }).order(:mode).first
    end
end
