# frozen_string_literal: true

module API
  module V3
    class ExercisePresenter < Struct.new(:exercise)
      def as_json(_opts)
        Rails.cache.fetch(['apiv3', exercise.cache_key_with_version, exercise.actors.cache_key_with_version]) do
          {
            id: exercise.slug,
            name: exercise.name,
            description: exercise.description,
            actors: exercise.actors.map do |actor|
              {
                id: actor.abbreviation,
                name: actor.name,
                numbered: { entries: actor.all_numbers },
                config_map: {}
              }
            end
          }
        end
      end
    end
  end
end
