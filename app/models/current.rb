# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :interfaces_cache,
    :services_cache,
    :networks_cache,
    :vm_cache,
    :user
end
