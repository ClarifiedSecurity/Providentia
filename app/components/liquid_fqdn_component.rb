# frozen_string_literal: true

class LiquidFQDNComponent < LiquidTooltipSnippetComponent
  private
    def template_text
      HostnameGenerator.result_for(spec, *options).fqdn
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
