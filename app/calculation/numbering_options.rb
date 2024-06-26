# frozen_string_literal: true

class NumberingOptions < Patterns::Calculation
  def result
    options[:hash].merge(
      collection:,
      include_blank:,
      disabled: forced_numbering?
    )
  end

  private
    def collection
      (available_actors + available_number_configs).map do |item|
        text_value = if item.is_a?(Actor)
          item.name
        else
          "#{item.actor.name} - #{item.name}"
        end
        [I18n.t('deploy_modes.per_item', item: text_value), item.to_gid]
      end
    end

    def include_blank
      I18n.t('deploy_modes.single') unless forced_numbering?
    end

    def forced_numbering?
      numbered_networks.any?
    end

    def available_actors
      scope = subject.exercise.actors.roots.numbered
      scope = scope.where(id: numbered_networks.map(&:actor).map(&:root_id)) if forced_numbering?
      scope
    end

    def numbered_networks
      subject.networks.select(&:numbered?)
    end

    def available_number_configs
      available_actors.flat_map(&:actor_number_configs)
    end
end
