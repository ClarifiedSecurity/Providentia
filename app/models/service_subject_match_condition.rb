# frozen_string_literal: true

class ServiceSubjectMatchCondition
  include ActiveModel::Model

  attr_accessor :matcher_type, :matcher_id, :invert

  VALID_TYPES = [
    CustomizationSpec,
    OperatingSystem,
    Capability,
    Network,
    Actor,
    ActsAsTaggableOn::Tagging,
    'SpecMode'
  ]

  validates :matcher_type, inclusion: { in: VALID_TYPES.map(&:to_s), allow_blank: true }
  validates :matcher_id, numericality: true, allow_blank: true, unless: -> { %w(ActsAsTaggableOn::Tagging SpecMode).include? matcher_type }

  def attributes
    {
      matcher_type:,
      matcher_id:,
      invert:
    }
  end

  def id
    Digest::SHA1.hexdigest(attributes.to_yaml)
  end

  def ==(other)
    other.is_a?(self.class) && other.attributes == attributes
  end

  def matched
    case matcher_type
    when 'ActsAsTaggableOn::Tagging'
      matcher_type.constantize.joins(:tag).where(tags: { name: matcher_id })
    when 'SpecMode'
      CustomizationSpec.where(mode: matcher_id)
    else
      matcher_type.constantize.where(id: matcher_id)
    end
  end
end
