# frozen_string_literal: true

class CloneExerciseForm < Patterns::Form
  param_key 'clone'

  attribute :exercise_id, Integer
  attribute :name, String
  attribute :abbreviation, String

  validate :target_does_not_exist?

  def source_name
    source_exercise.name
  end

  def source_abbreviation
    source_exercise.abbreviation
  end

  private
    def persist
      CloneEnvironment.result_for(exercise_id, attributes)
    end

    def target_does_not_exist?
      if Exercise.where(name: name).exists?
        errors.add(:name, "An exercise with the name '#{name}' already exists.")
      end
      if Exercise.where(abbreviation: abbreviation).exists?
        errors.add(:abbreviation, "An exercise with the abbreviation '#{abbreviation}' already exists.")
      end
    end

    def source_exercise
      @source_exercise ||= Exercise.find(exercise_id)
    end
end
