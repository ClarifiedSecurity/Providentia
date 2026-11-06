# frozen_string_literal: true

class DuplicateVirtualMachineForm < Patterns::Form
  param_key 'duplicate'

  attribute :virtual_machine_id, Integer
  attribute :name, String

  validate :name_available

  attr_reader :duplicated

  def source_name
    source.name
  end

  private
    def persist
      @duplicated = DuplicateVirtualMachine.result_for(source, name:, user: Current.user)
      true
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each { |message| errors.add(:name, message) }
      false
    end

    def name_available
      if name.blank?
        errors.add(:name, :blank)
      elsif VirtualMachine.exists?(exercise_id: source.exercise_id, name: name.to_s.downcase)
        errors.add(:name, :taken)
      end
    end

    def source
      @source ||= VirtualMachine.find(virtual_machine_id)
    end
end
