# frozen_string_literal: true

class UpdateServiceSpecCache < Patterns::Calculation
  private
    def result
      ServiceSubject.transaction do
        [subject, options[:item_hint]].compact.flat_map(&method(:gather_subjects)).uniq.each do |subject|
          next if subject.customization_spec_ids == subject.matched_spec_ids
          subject.update_columns(
            customization_spec_ids: subject.matched_spec_ids,
            updated_at: Time.current
          )
        end
      end
    end

    def gather_subjects(from)
      case from
      when Service
        from.service_subjects.to_a
      when ServiceSubject
        [from]
      when CustomizationSpec
        ServiceSubject.search_matcher(from).to_a
      when VirtualMachine
        acc = []
        if from.previous_changes[:operating_system_id]
          acc << from.previous_changes[:operating_system_id].flat_map do |os_id|
            OperatingSystem.path_of(os_id) if os_id
          end.compact
        end
        if from.previous_changes[:actor_id]
          acc << Actor.where(id: from.previous_changes[:actor_id])
        end
        ServiceSubject.search_matcher(acc.flatten).to_a
      when NetworkInterface
        ServiceSubject.search_matcher(Network.find(from.network_id, from.network_id_previously_was)).to_a
      when Capability
        # only reaches here from association callback,
        # which includes both addition and removal
        ServiceSubject.search_matcher(from).to_a
      when ActsAsTaggableOn::Tagging
        ServiceSubject.search_matcher(OpenStruct.new(id: from.tag.name, class: from.class)).to_a
      else
        raise "Unknown item for service cache update: #{from.inspect}"
      end
    end
end