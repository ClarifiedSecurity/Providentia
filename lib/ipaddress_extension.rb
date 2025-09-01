# frozen_string_literal: true

module IpaddressExtension
  module IPv4
    def eql?(oth)
      self.hash == oth.hash
    end

    def hash
      [ to_u32, prefix.to_u32 ].hash
    end

    def ptr_record
      if @prefix <= 24
        return @octets[3].to_s, "#{octets[0..2].reverse.join(".")}.in-addr.arpa"
      end
    end
  end

  module IPv6
    def eql?(oth)
      self.hash == oth.hash
    end

    def hash
      [ to_u128, prefix.to_u128 ].hash
    end

    def ptr_record
      zone = to_hex[0..@prefix.to_i / 4 - 1].reverse.gsub(/./) { |c| c + '.' }
      host = to_hex[@prefix.to_i / 4..-1].reverse.gsub(/./) { |c| c + '.' }

      return host, zone + 'ip6.arpa'
    end
  end
end

IPAddress::IPv4.include IpaddressExtension::IPv4
IPAddress::IPv6.include IpaddressExtension::IPv6
