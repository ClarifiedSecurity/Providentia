# frozen_string_literal: true

class NetworkInterface < ApplicationRecord
  include SpecCacheUpdateOnSave
  include SpecCacheUpdateBeforeDestroy
  has_paper_trail

  default_scope { order(:created_at) }

  belongs_to :virtual_machine, touch: true
  belongs_to :network, touch: true
  has_many :addresses, dependent: :destroy

  delegate :exercise, to: :virtual_machine, allow_nil: true

  accepts_nested_attributes_for :addresses,
    reject_if: proc { |attributes| attributes.all? { |key, value| value.blank? || value == '0' } }

  after_save :update_numbered_actor, if: :network_id_previously_changed?
  after_save :network_change_cleanup

  validate :network_in_exercise

  scope :egress, -> { where(egress: true) }
  scope :connectable, -> { joins(:addresses).where(addresses: { connection: true }) }
  scope :for_api, -> {
    eager_load(addresses: [:address_pool], network: [:exercise, :address_pools])
  }

  def self.to_icon
    'fa-network-wired'
  end

  def connection?
    addresses.any?(&:connection?)
  end

  private
    def network_in_exercise
      return unless network
      return if network.exercise == virtual_machine.exercise
      errors.add(:network, :invalid)
    end

    def network_change_cleanup
      return unless persisted? && network_id_previously_changed?
      Address.transaction do
        addresses.destroy_all
        network.address_pools.order(:created_at).each do |pool|
          pool.addresses.create(
            network_interface: self,
            network: pool.network,
            mode: pool.default_address_mode
          )
        end
      end
    end

    def update_numbered_actor
      virtual_machine.update numbered_by: network.actor.root if network.numbered?
    end
end
