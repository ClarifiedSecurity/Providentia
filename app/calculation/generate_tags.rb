# frozen_string_literal: true

class GenerateTags < Patterns::Calculation
  private
    def result
      case subject
      when OperatingSystem
        os_result
      when Actor
        actor_result
      when Network
        network_result
      when VirtualMachine
        virtual_machine_result || []
      when CustomizationSpec
        spec_result
      when Capability
        capability_result
      when API::V3::InstancePresenter
        instance_result || []
      when Enumerable
        subject.map { |item| self.class.result_for(item, options) }.flatten
      else
        []
      end.flatten.compact
    end

    def os_result
      [{
        id: subject.api_short_name,
        name: subject.name,
        config_map: {},
        children: subject.children.map(&:api_short_name)
      }]
    end

    def actor_result
      [
        {
          id: ActorAPIName.result_for(subject),
          name: subject.name,
          config_map: {},
          children: numbered_actors.map { |h| h[:id] },
        },
        subject.as_team_api,
        numbered_actors,
        actors_as_numbered_for_vms
      ].reject(&:blank?)
    end

    def numbered_actors
      return [] if options[:spec] || !subject.root.number?
      subject.root.all_numbers.map do |number|
        configs = subject
          .root
          .actor_number_configs
          .where('matcher @> :nr::jsonb', nr: [number.to_s].to_json)
        {
          id: ActorAPIName.result_for(subject, number:),
          name: "#{subject.name} number #{number}",
          config_map: configs.map(&:config_map).reduce(&:merge) || {},
          children: [],
        }
      end
    end

    def actors_as_numbered_for_vms
      return if options[:spec] # this is only needed if "overall" tags list is generated, not for specific spec
      subject
        .numbered_virtual_machines
        .map(&:actor)
        .select(&:is_root?)
        .uniq
        .excluding(subject)
        .map do |vm_actor|
          children = subject.all_numbers.map do |number|
            configs = subject
              .actor_number_configs
              .where('matcher @> :nr::jsonb', nr: [number.to_s].to_json)
            {
              id: ActorAPIName.result_for(vm_actor, numbered_by: subject, number:),
              name: "#{vm_actor.name}, numbered by #{subject.name} - number #{number}",
              config_map: configs.map(&:config_map).reduce(&:merge) || {},
              children: [],
            }
          end

          [{
            id: ActorAPIName.result_for(vm_actor, numbered_by: subject),
            name: "#{vm_actor.name}, numbered by #{subject.name}",
            config_map: {},
            children: children.map { |entry| entry[:id] },
          }] + children
        end
    end

    def network_result
      [{
        id: subject.api_short_name,
        name: subject.name,
        config_map: {
          domain: subject.full_domain
        },
        children: []
      }]
    end

    def virtual_machine_result
      return unless subject.numbered_actor && !subject.numbered_actor.subtree.include?(subject.actor)
      [{
        id: ActorAPIName.result_for(subject.actor, numbered_by: subject.numbered_actor),
        name: ActorAPIName.result_for(subject.actor, numbered_by: subject.numbered_actor),
        config_map: {},
        children: []
      }]
    end

    def spec_result
      many_items = subject.virtual_machine.custom_instance_count.to_i > 1 || subject.virtual_machine.numbered_actor
      subject.tag_list.map do |custom_tag|
        {
          id: "custom_#{custom_tag}",
          name: "Custom tag #{custom_tag}",
          config_map: {},
          children: []
        }
      end + [
        ({ id: subject.slug.tr('-', '_'), name: "All instances of #{subject.slug}", config_map: {}, children: [] } if many_items),
        ({ id: 'customization_container', name: 'customization_container', config_map: {}, children: [] } if subject.mode_container?),
      ]
    end

    def capability_result
      [{
        id: "capability_#{subject.slug}".downcase.tr('-', '_'),
        name: subject.name,
        config_map: {},
        children: [],
      }]
    end

    def instance_result
      return if !subject.team_number

      actor = subject.spec.virtual_machine.actor
      nr_actor = subject.spec.virtual_machine.numbered_actor

      if nr_actor.subtree.include?(actor)
        [{
          id: ActorAPIName.result_for(actor, number: subject.team_number),
          name: "#{actor.name} number #{subject.team_number}",
          config_map: {},
          children: [],
        }]
      else
        [{
          id: ActorAPIName.result_for(actor, numbered_by: nr_actor, number: subject.team_number),
          name: "#{actor.name}, numbered by #{nr_actor.name} - number #{subject.team_number}",
          config_map: {},
          children: [],
        }]
      end
    end
end
