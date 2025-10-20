# frozen_string_literal: true

class NetworkAddressNormalizer < Patterns::Calculation
  TEMPLATE_RE = /{{|}}|#+/
  IPV6_HEXTET_COUNT = 8

  private
    def result
      return '' if subject.network_address.blank?

      subject.network_address.match?(TEMPLATE_RE) ? normalize_templated_address : normalize_non_templated_address
    end

    def normalize_non_templated_address
      IPAddress(subject.network_address).network.to_string
    end

    def normalize_templated_address
      network_ip = subject.ip_network
      case subject.ip_family.to_sym
      when :v4
        merge_parts(network_ip.octets.map(&:to_s), subject.network_address.split('/').first.split('.'), '.', network_ip.prefix)
      when :v6
        network_hextets = network_ip.hexs.map { |h| h.to_s.downcase }
        input_hextets = decompressed_hextets

        merge_parts(network_hextets, input_hextets, ':', network_ip.prefix)
          .gsub(/(:0)+/, '::')
          .sub(':::', '::')
      end
    end

    def merge_parts(network_parts, input_parts, separator, prefix)
      merged = network_parts.each_with_index.map do |net_part, idx|
        template?(input_parts[idx]) ? input_parts[idx] : normalize_part(net_part)
      end
      "#{merged.join(separator)}/#{prefix}"
    end

    def normalize_part(hex)
      hex.to_i(16).to_s(16)
    end

    def decompressed_hextets
      addr_only = subject.network_address.split('/').first
      if addr_only.include?('::')
        before, after = addr_only.split('::', 2)
        before_parts = before.empty? ? [] : before.split(':')
        after_parts  = after.empty?  ? [] : after.split(':')
        missing = IPV6_HEXTET_COUNT - (before_parts.length + after_parts.length)
        middle = Array.new([missing, 0].max, '0')
        (before_parts + middle + after_parts)
      else
        addr_only.split(':')
      end
    end

    def template?(part)
      part && part.match?(TEMPLATE_RE)
    end
end
