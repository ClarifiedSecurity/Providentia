# frozen_string_literal: true

class Page::Exercise::Component < ApplicationViewComponent
  Feature = Data.define(:name, :assets)

  param :exercise

  private
    def before_render
      title exercise.name
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
      scope = authorized_scope(asset.where(exercise:))
      Rails.cache.fetch([exercise.cache_key_with_version, scope.cache_key_with_version, 'count']) do
        scope.count
      end
    end

    def actors
      controller.instance_variable_get('@actors')
    end

    def resource_cache_key
      [
        'resource',
        authorized_scope(@exercise.virtual_machines).cache_key_with_version,
        authorized_scope(@exercise.networks).cache_key_with_version
      ]
    end

    def resource_usage
      ExerciseResourceUsage.result_for(exercise)
    end
end
