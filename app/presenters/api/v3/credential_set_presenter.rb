# frozen_string_literal: true

module API
  module V3
    class CredentialSetPresenter < Struct.new(:credential_set)
      delegate :network, to: :credential_set
      delegate :actor, to: :network

      def as_json(_opts)
        Rails.cache.fetch(['apiv3', credential_set.cache_key_with_version, credential_set.credential_bindings.cache_key_with_version]) do
          {
            id: credential_set.slug,
            name: credential_set.name,
            actor: (ActorAPIName.result_for(actor) if network),
            numbers:
          }
        end
      end

      private
        def numbers_configuration
          if network
            NetworkInstances.result_for(network)
          else
            ['all']
          end
        end

        def numbers
          numbers_configuration.index_with { credentials(_1) }
        end

        def credentials(number)
          credential_set.credentials.map do |cred|
            domain_username = if credential_set.network
              [
                credential_set.network_domain_prefix,
                cred.username
              ].join('\\')
            end
            {
              name: cred.name,
              password: cred.password,
              username: cred.username,
              email: StringSubstituter.result_for(cred.email, { actor_nr: number }),
              domain_username:,
              config_map: JSON.parse(
                StringSubstituter.result_for(
                  JSON.dump(cred.config_map), { actor_nr: number }
                )
              )
            }
          end
        end
    end
  end
end
