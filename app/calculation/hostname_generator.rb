# frozen_string_literal: true

class HostnameGenerator < Patterns::Calculation
  Names = Data.define(:hostname, :domain, :fqdn)

  private
    def result
      subject.virtual_machine = virtual_machine
      Names.new(
        hostname:,
        domain:,
        fqdn: [hostname, domain].reject(&:blank?).join('.')
      )
    end

    def virtual_machine
      options[:vm] || subject.virtual_machine
    end

    def address
      options[:address] || virtual_machine.connection_address
    end

    def domain
      address&.domain_binding&.full_name || options[:fallback_domain]
    end

    def hostname
      [subject.hostname, suffixes].flatten.compact.join
    end

    def suffixes
      [].tap do |parts|
        parts << '{{ seq }}' if virtual_machine.clustered?
        parts << '{{ team_nr_str }}' if team_suffix?
      end.join('-')
    end

    def team_suffix?
      virtual_machine.numbered_actor && (!address || !address.network&.numbered?)
    end
end
