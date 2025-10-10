# frozen_string_literal: true

class StringSubstituter < Patterns::Calculation
  VALID_LIQUID_KEYS = %i(seq team_nr actor_nr)

  private
    def result
      numbering_substitution(liquid_substitution)
    end

    def numbering_substitution(text)
      NumberingTools.substitute(text, options[:actor_nr])
    end

    def liquid_substitution
      Liquid::Template.parse(subject, error_mode: :strict)
        .render(substitution_keys)
    end

    def substitution_keys
      options.slice(*VALID_LIQUID_KEYS).symbolize_keys.tap do |keys|
        keys[:seq] = keys[:seq].to_s.rjust(2, '0') if keys[:seq]
        if keys[:actor_nr]
          keys[:team_nr] = keys[:actor_nr]
          keys[:team_nr_str] = keys[:actor_nr_str] = keys[:actor_nr].to_s.rjust(2, '0')
        end
      end.stringify_keys
    end
end
