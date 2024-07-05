# frozen_string_literal: true

class AddressForm < Patterns::Form
  param_key 'address'

  attribute :mode, Symbol
  attribute :ip_family, Symbol
  attribute :address_pool_id, Integer
  attribute :offset, String
  attribute :offset_address, String, default: ->(form, attribute) { form.send(:resource).ip_object.to_s if form.offset }
  attribute :ipv6_address_input, String, default: ->(form, attribute) { Ipv6Offset.load(form.send(:resource).offset) }
  attribute :dns_enabled, Boolean
  attribute :connection, Boolean

  def available_modes
    Address.modes.keys.tap do |modes|
      modes -= %w(ipv4_static ipv4_vip) if resource.network.address_pools.ip_v4.empty?
      modes - %w(ipv6_static ipv6_vip) if resource.network.address_pools.ip_v6.empty?
    end.partition { _1.start_with?('ipv4') }[ip_family == :ipv4 ? 0 : 1].map do |mode|
      [I18n.t("address_modes.#{mode}"), mode]
    end
  end

  def offset_address=(input)
    return if ip_family == :ipv6
    super(input) # set internal variable, not offset

    if input.blank?
      self.offset = nil
    else
      network_object = resource.ip_family_network
      address = IPAddress::IPv4.new("#{input}/#{network_object.prefix}") rescue nil
      if address && network_object.include?(address)
        self.offset = address.u32 - network_object.network_u32 - 1
      else
        errors.add(:offset, :invalid)
        errors.add(:offset_address, :invalid)
      end
    end
  end

  def ipv6_address_input=(input)
    return if ip_family == :ipv4
    return if resource.offset.nil? && input.blank?

    super(input) # set internal variable, not offset
    self.offset = if input.blank?
      self.offset = nil
    else
      Ipv6Offset.dump(input)
    end
  rescue ArgumentError
    self.errors.add(:ipv6_address_input, :invalid)
  rescue StopIteration
    self.errors.add(:ipv6_address_input, :invalid)
  end

  private
    def persist
      # set default mode on ip family change
      self.mode = available_modes.dig(0, 1).to_sym if ip_family != resource.ip_family
      resource.update(attributes.slice(:address_pool_id, :offset, :mode, :dns_enabled, :connection))
    end
end