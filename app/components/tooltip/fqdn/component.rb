# frozen_string_literal: true

class Tooltip::FQDN::Component < Tooltip::Component
  private
    def template_text
      HostnameGenerator.result_for(spec).fqdn
    end

    def spec
      case @object
      when CustomizationSpec
        @object
      when VirtualMachine
        @object.host_spec
      end
    end
end
