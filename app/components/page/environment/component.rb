# frozen_string_literal: true

class Page::Environment::Component < ApplicationViewComponent
  Feature = Data.define(:name, :assets)

  param :environment

  private
    def before_render
      title environment.name
    end

    def features
      [
        Feature.new('Inventory', [VirtualMachine, Capability]),
        Feature.new('Networking', [Network, Domain]),
        Feature.new('Monitoring', [Service]),
        (Feature.new('Credentials', [CredentialSet]) if Rails.configuration.x.features.dig(:credentials))
      ].compact
    end

    def ar_class_to_link_text(klass)
      i18n_plural = klass.model_name.human(count: 2)
      if i18n_plural == klass.model_name.human
        klass.model_name.human.pluralize
      else
        i18n_plural
      end
    end

    def asset_count(asset)
      scope = authorized_scope(asset.where(exercise: environment))
      Rails.cache.fetch([environment.cache_key_with_version, scope.cache_key_with_version, 'count']) do
        scope.count
      end
    end

    def actors
      controller.instance_variable_get('@actors')
    end

    def resource_cache_key
      [
        'resource',
        authorized_scope(environment.virtual_machines).cache_key_with_version,
        authorized_scope(environment.networks).cache_key_with_version
      ]
    end

    def resource_usage
      ExerciseResourceUsage.result_for(exercise)
    end
end
