# frozen_string_literal: true

if ENV.fetch('OIDC_ENABLE_HTTP', 'false') == 'true'
  Module.new do
    attr_reader :scheme

    def initialize(uri)
      @scheme = uri.scheme
      super
    end

    def endpoint
      URI::Generic.build(scheme:, host:, port:, path:)
    rescue URI::Error => e
      raise SWD::Exception.new(e.message)
    end

    prepend_features(::OpenIDConnect::Discovery::Provider::Config::Resource)
  end
end
