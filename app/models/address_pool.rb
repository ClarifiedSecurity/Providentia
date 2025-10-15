# frozen_string_literal: true

class AddressPool < ApplicationRecord
  extend FriendlyId
  has_paper_trail
  friendly_id :slug_candidates, use: [:slugged, :scoped], scope: :network

  belongs_to :network, touch: true
  has_one :exercise, through: :network
  has_many :addresses

  enum :ip_family, { v4: 1, v6: 2 }, prefix: :ip, default: 'v4'
  enum :scope, { default: 1, mgmt: 2, other: 999 }, prefix: :scope, default: 'default'

  validates :name, :ip_family, :scope, presence: true
  validates :network_address, format: {
    with: /\A(?>(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9#]){1,3}\.){3}(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9#]){1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))\z/,
    allow_nil: true
  }, if: :ip_v4?
  validates :network_address, format: {
    with: /\A((((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){7}((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){6}(:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}|((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){5}(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,2})|:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){4}(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,3})|((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4})?:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){3}(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,4})|((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){0,2}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){2}(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,5})|((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){0,3}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(((?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}:){1}(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,6})|((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){0,4}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(:(((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){1,7})|((:(?>{{\s*[-,\w.'|:\s]+\s*}}|[0-9A-Fa-f#]){1,4}){0,5}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:)))(%.+)?s*\/([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-8])?\z/,
    allow_nil: true
  }, if: :ip_v6?

  validate :parsed_network_address_valid?

  scope :for_address, ->(address) {
    where(ip_family: address.ipv4? ? :v4 : :v6)
  }

  before_validation :set_default_ipv6_gw_offset, :set_mgmt_default_name
  before_update :clear_dangling_addresses, :clear_address_range
  after_validation :revert_invalid_network_values

  def self.to_icon
    'fa-network-wired'
  end

  def numbered?
    network_address =~ /#|team_nr|actor_nr/
  end

  def gateway_address_object
    return if gateway.blank?
    Address.new(
      mode: default_address_mode,
      address_pool: self,
      network:,
      offset: gateway
    )
  end

  def gateway_ip(team = nil)
    return unless gateway
    ip_network(team).allocate(gateway - (ip_v6? ? 1 : 0))
  end

  def ip_network(team = nil, base = network_address.dup)
    return unless base

    if last_octet_is_dynamic?
      first_net = IPAddress(StringSubstituter.result_for(base, { actor_nr: 1 })).network
      IPAddress::IPv4.parse_u32(
        first_net.to_i + ((team || 1) - 1) * first_net.size, first_net.prefix
      )
    else
      templated = StringSubstituter.result_for(base, { actor_nr: team || 1 })
      IPAddress(templated).network
    end
  end

  def last_octet_is_dynamic?
    ip_v4? && network_address && (network_address =~ /\.\d+\/\d+\z/).nil?
  end

  def available_range
    raise 'attempt to iterate over ipv6, bad idea!' unless ip_v4?
    @available_ipv4_range ||= ip_network.hosts[(range_start || 0)..(range_end || -1)]
  end

  def should_generate_new_friendly_id?
    name_changed? || scope_changed? || ip_family_changed? || super
  end

  def slug_candidates
    [
      [:scope, :name],
      [:scope, :ip_family, :name]
    ]
  end

  def default_address_mode
    "ip#{ip_family}_static"
  end

  private
    def clear_dangling_addresses
      return unless network_address_changed? || range_start_changed? || range_end_changed?
      clear_dangling_ipv4 if ip_v4?
      clear_dangling_ipv6 if ip_v6?
    end

    def clear_dangling_ipv4
      return if !network_address
      available_range.map(&:to_u32).to_set

      clear_dangling_ipv4_gateway
      clear_dangling_ipv4_addresses
    end

    def clear_dangling_ipv4_gateway
      return if !gateway || network_address_was.blank?

      all_hosts = available_range.map(&:to_u32).to_set
      previous_gateway = ip_network(nil, network_address_was.dup).allocate(gateway)
      self.gateway = nil if !all_hosts.include?(previous_gateway.to_u32)
    end

    def clear_dangling_ipv4_addresses
      all_hosts = available_range.map(&:to_u32).to_set
      addresses.mode_ipv4_static.where.not(offset: nil).each do |address|
        used_addresses = begin
          address.all_ip_objects.map(&:to_u32).to_set
       rescue StopIteration
         Set.new([-1])
        end
        next if all_hosts > used_addresses # no "overflowing" addresses
        address.update(offset: nil)
      end
    end

    def clear_dangling_ipv6
      addresses.where(mode: %i(ipv6_static ipv6_vip)).where.not(offset: nil).each do |address|
        next if address.all_ip_objects.all? { |ip|
          ip_network.include? IPAddress::IPv6.new("#{ip}/#{ip_network.prefix}")
        }
        address.update(offset: nil)
      end
    end

    def clear_address_range
      if network_address_changed? && last_octet_is_dynamic?
        self.range_start = nil
        self.range_end = nil
      end
    end

    def parsed_network_address_valid?
      number = network.actor.root&.number
      ip_network(number).present?
    rescue Liquid::SyntaxError => e
      errors.add(:network_address, "Invalid template syntax: #{e.message}")
    rescue ArgumentError => e
      case e.message
      when /\A(?:Invalid IP|Unknown IP Address) "?(.*)"?\z/
        errors.add(:network_address, "parses to invalid address: #{$1}")
      else
        errors.add(:network_address, e.message.downcase)
      end
    end

    def revert_invalid_network_values
      self.gateway = gateway_was if errors[:gateway].any?
      self.network_address = network_address_was if errors[:network_address].any?
    end

    def set_mgmt_default_name
      return unless scope_changed? && scope_mgmt?
      self.name = 'MGMT'
      self.ip_family = 'v6'
      self.gateway = nil
    end

    def set_default_ipv6_gw_offset
      self.gateway = 1 if !scope_mgmt? && ip_family == 'v6' && network_address_changed?
    end
end
