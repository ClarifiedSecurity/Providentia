# frozen_string_literal: true

class NetworkInstances < Patterns::Calculation
  private
    def result
      if subject.numbered? && subject.actor.root.number?
        subject.actor.root.all_numbers
      else
        [nil]
      end
    end
end
