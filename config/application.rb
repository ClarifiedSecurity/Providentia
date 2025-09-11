# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Providentia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # enable load_async
    config.active_record.async_query_executor = :global_thread_pool

    config.resource_prefix = ENV.fetch('OIDC_RESOURCE_PREFIX', '')
    config.oidc_issuer = ENV.fetch('OIDC_ISSUER', '')
    config.oidc_extra_scopes = ENV.fetch('OIDC_EXTRA_SCOPES', '').split(',').map(&:to_sym)
    config.oidc_authorization_roles_claim = ENV.fetch('OIDC_AUTHORIZATION_ROLES_CLAIM', '').split('.')

    config.action_dispatch.default_headers.merge!(
      'X-Frame-Options' => 'DENY',
      'Cross-Origin-Embedder-Policy-Report-Only' => 'require-corp',
      'Cross-Origin-Opener-Policy' => 'same-origin'
    )
    config.x.features = config_for(:features) || {}
  end
end
