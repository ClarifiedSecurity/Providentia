# frozen_string_literal: true

class Tooltip::Domain::Component < Tooltip::Component
  private
    def template_text
      HostnameGenerator.result_for(@object.host_spec).domain
    end
end
