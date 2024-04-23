# frozen_string_literal: true

module API
  module V3
    class TagsPresenter < Struct.new(:exercise, :scope)
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

      private
        def spec_scope
          @spec_scope ||= Pundit.policy_scope(scope, exercise.customization_specs)
        end

        def vm_scope
          @vm_scope ||= Pundit.policy_scope(scope, exercise.virtual_machines)
        end
    end
  end
end
