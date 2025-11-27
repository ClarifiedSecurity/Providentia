# frozen_string_literal: true

class IPPicker::Component < ApplicationViewComponent
  attr_reader :label

  def initialize(form:, field:, hosts: :all, label: true)
    @form = form
    @field = field
    @hosts = hosts
    @label = label
  end

  def render?
    address_pool.ip_v4? && address_pool.ip_network
  end

  private
    def renders_as_select?
      address_pool.ip_network.prefix >= 22
    end

    def field_name
      if renders_as_select?
        @field.to_s
      else
        "#{@field}_address"
      end
    end

    def field_id
      "#{dom_id(real_form_object)}_#{field_name}"
    end

    def collection
      address_ip_objects.map do |ip_object|
        address = address_for_ip_object(ip_object)
        [
          AddressValues.result_for(address) || unsubstituted_address_text(ip_object),
          ip_object.u32 - address_pool.ip_network.network_u32 - 1
        ]
      end.sort_by(&:last).uniq
    end

    def address_ip_objects
      case @hosts
      when :available_for_object # for specific network interface
        AvailableIPBlock.result_for(real_form_object)
      when :all
        address_pool.ip_network.hosts
      end
    end

    def address_pool
      @address_pool ||= case real_form_object
                        when AddressPool
                          real_form_object
                        when Address
                          real_form_object.address_pool
      end
    end

    def real_form_object
      @form.object.send(:resource)
    end

    def address_for_ip_object(ip_object)
      address_pool.addresses.build(network: address_pool.network, offset: ip_object.to_u32 - ip_object.network.to_u32 - 1)
    end

    def disabled
      !helpers.allowed_to?(:update?, real_form_object)
    end

    def unsubstituted_address_text(ip_object)
      result = address_pool.network_address.split('/').first.split('.')
      network_address = address_pool.ip_network
      ip_object.octets.each_with_index do |octet, idx|
        if result[idx].match?(/{{|}}|#+/)
          diff = ip_object.octets[idx] - network_address.octets[idx]
          suffix = diff.positive? ? " + #{diff}" : ''
          result[idx] = LiquidReplacer.new(result[idx]).iterate do |variable_node|
            "[ #{variable_node.name.name}#{suffix} ]"
          end
        else
          result[idx] = octet.to_s
        end
      end
      result.join('.')
    end
end
