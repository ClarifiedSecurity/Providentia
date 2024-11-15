# frozen_string_literal: true

class GenerateTags < Patterns::Calculation
  include ActionPolicy::Behaviour
  authorize :user, through: -> { Current.user }

  ApiTag = Data.define(:id, :name, :config_map, :priority) do
    def initialize(id:, name: nil, config_map: {}, priority:)
      super(id:, name: name || id, config_map:, priority:)
    end
  end

  CustomizationContainer = Data.define
  MultiContainer = Data.define(:spec)
  AllSpecs = Data.define(:virtual_machine)
  ActorWithNumber = Data.define(:actor, :number)
  NumberedByAnotherActor = Data.define(:actor, :numbered_actor, :number) do
    def initialize(actor:, numbered_actor:, number: nil)
      super(actor:, numbered_actor:, number:)
    end
  end

  attr_reader :tag_sources

  private
    def result
      @tag_sources = Set.new
      resolve_inputs
      tags_from_tag_sources
    end

    def resolve_inputs(item = subject)
      case item
      when Enumerable
        item.compact.each { resolve_inputs(_1) }
      when API::V3::CustomizationSpecPresenter
        resolve_inputs([
          item.spec.virtual_machine.connection_nic&.network,
          item.spec.virtual_machine.operating_system,
          item.spec.virtual_machine.actor,
          item.spec.virtual_machine,
          item.spec,
          item.spec.capabilities
        ])
      when API::V3::InstancePresenter
        return if !item.actor_number
        actor = item.spec.virtual_machine.actor
        numbered_actor = item.spec.virtual_machine.numbered_actor
        if actor.path.include?(numbered_actor)
          resolve_inputs(actor.path.map { ActorWithNumber.new(actor: _1, number: item.actor_number) })
        else
          tag_sources.add NumberedByAnotherActor.new(actor:, numbered_actor:, number: item.actor_number)
        end
      when Actor, OperatingSystem
        item.path.each { tag_sources.add _1 }
      when CustomizationSpec
        tag_sources.add CustomizationContainer.new if item.mode_container?
        tag_sources.add MultiContainer.new(item) if item.virtual_machine.clustered? && item.cluster_mode? || item.virtual_machine.numbered_by
        resolve_inputs(item.taggings)
      when VirtualMachine
        tag_sources.add AllSpecs.new(item) if item.customization_specs.size > 1
        tag_sources.add NumberedByAnotherActor.new(actor: item.actor, numbered_actor: item.numbered_actor) if item.numbered_actor && !item.numbered_actor.subtree.include?(item.actor)
      when ActsAsTaggableOn::Tagging
        tag_sources.add item.tag if allowed_to?(:read_tags?, item.taggable)
      when Network, Capability, ActorWithNumber
        tag_sources.add item
      end
    end

    def tags_from_tag_sources
      tag_sources.filter_map do |item|
        case item
        when OperatingSystem
          ApiTag.new(id: item.api_short_name, name: item.name, priority: 10 + item.depth)
        when Capability
          ApiTag.new(id: "capability_#{item.slug}".to_url.tr('-', '_'), name: item.name, priority: 20)
        when Actor
          ApiTag.new(id: ActorAPIName.result_for(item), name: item.name, priority: 30 + item.depth)
        when ActorWithNumber
          ApiTag.new(
            id: ActorAPIName.result_for(item.actor, number: item.number),
            name: "#{item.actor.name} number #{item.number}",
            config_map: item.actor.actor_number_configs.for_number(item.number).pluck(:config_map).reduce(&:merge) || {},
            priority: 31 + item.actor.depth * 3
          )
        when NumberedByAnotherActor
          name = "#{item.actor.name}, numbered by #{item.numbered_actor.name}"
          name += " - number #{item.number}" if item.number
          ApiTag.new(
            id: ActorAPIName.result_for(item.actor, numbered_by: item.numbered_actor, number: item.number),
            name:,
            priority: 32 + item.actor.depth * 3
          )
        when Network
          ApiTag.new(id: item.api_short_name, name: item.name, priority: 80, config_map: {})
        when MultiContainer
          ApiTag.new(id: item.spec.slug.tr('-', '_'), name: "All instances of #{item.spec.slug}", priority: 90)
        when CustomizationContainer
          ApiTag.new(id: 'customization_container', priority: 95)
        when AllSpecs
          ApiTag.new(id: "#{item.virtual_machine.name.tr('-', '_')}_all_specs", name: "All specs for #{item.virtual_machine.name}", priority: 95)
        when ActsAsTaggableOn::Tag
          ApiTag.new(id: "custom_#{item.name}", name: "Custom tag #{item.name}", priority: 100)
        end
      end
    end
end
