# frozen_string_literal: true

if ENV.fetch('OIDC_ENABLE_HTTP', 'false') == 'true'
  SWD.url_builder = URI::HTTP
end
