# frozen_string_literal: true

module API
  module V3
    class TagsPresenter < Struct.new(:exercise, :spec_scope, :vm_scope)
      def as_json(_opts)
        Rails.cache.fetch(['apiv3', exercise.cache_key_with_version, 'spec_instance_tags', spec_scope.cache_key_with_version, vm_scope.cache_key_with_version]) do
          GenerateTags.result_for(
            spec_scope.all.map do |spec|
              [
                CustomizationSpecPresenter.new(spec),
                spec.deployable_instances(InstancePresenter)
              ]
            end
          )
        end
      end
    end
  end
end
