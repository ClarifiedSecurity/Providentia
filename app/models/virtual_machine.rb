# frozen_string_literal: true

class VirtualMachine < ApplicationRecord
  include VisibilityFromActor
  include SpecCacheUpdateOnSave
  include SpecCacheUpdateBeforeDestroy
  has_paper_trail

  attribute :visibility, :integer # rails bug during migrations
  enum :visibility, { public: 1, actor_only: 2  }, prefix: :visibility

  belongs_to :exercise
  belongs_to :actor
  belongs_to :operating_system, optional: true
  belongs_to :system_owner, class_name: 'User', inverse_of: :owned_systems, optional: true
  belongs_to :numbered_by, polymorphic: true, optional: true
  has_many :network_interfaces, dependent: :destroy
  has_many :customization_specs, dependent: :destroy
  has_many :networks, through: :network_interfaces
  has_many :addresses, through: :network_interfaces
  has_and_belongs_to_many :services,
    after_add: :invalidate_cache, after_remove: :invalidate_cache

  has_one :connection_nic, -> { connectable },
    class_name: 'NetworkInterface', foreign_key: :virtual_machine_id
  has_one :host_spec, -> { mode_host },
    class_name: 'CustomizationSpec', foreign_key: :virtual_machine_id

  accepts_nested_attributes_for :network_interfaces,
    reject_if: proc { |attributes| attributes.all? { |key, value| value.blank? || value == '0' } }

  scope :search, ->(query) {
    columns = %w{virtual_machines.name customization_specs.dns_name users.name operating_systems.name tags.name}
    left_outer_joins(:system_owner, :operating_system, customization_specs: { taggings: [:tag] })
      .where(
        columns
          .map { |c| "lower(#{c}) ilike :search" }
          .join(' OR '),
        search: "%#{query.downcase}%"
      )
      .group(:id)
  }

  validates :name, uniqueness: { scope: :exercise }, presence: true, length: { minimum: 1, maximum: 63 }, hostname: true
  validates :ram, numericality: true, inclusion: 1..2000, allow_blank: true
  validates :cpu, numericality: { only_integer: true }, inclusion: 1..100, allow_blank: true
  validates :custom_instance_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_blank: true
  validates :numbered_by_type, inclusion: { in: %w(Actor ActorNumberConfig) }, if: :numbered_by
  validates_associated :network_interfaces
  validate :hostname_conflicts, :transfer_overlap_error, :forced_numbered_by

  before_validation :lowercase_fields
  after_create :create_default_spec
  after_update :sync_host_spec_name
  after_touch :ensure_nic_status

  def self.to_icon
    'fa-server'
  end

  def vm_name
    "#{exercise.abbreviation}_#{actor.abbreviation}_#{name}".downcase
  end

  def numbered_actor
    case numbered_by
    when Actor
      numbered_by
    when ActorNumberConfig
      numbered_by.actor
    end
  end

  def single_network_instances(presenter)
    if numbered_actor && connection_nic.network.numbered?
      host_spec.sequential_numbers.map do |seq|
        presenter.new(host_spec, seq, nil)
      end
    else
      host_spec.deployable_instances(presenter)
    end
  end

  def clustered?
    custom_instance_count.to_i > 0
  end

  def connection_address
    return unless connection_nic
    connection_nic.addresses.detect(&:connection?)
  end

  def deployable_instances(cluster_mode = true)
    (team_numbers || [nil]).product(cluster_mode && sequential_numbers || [nil])
  end

  def team_numbers
    if numbered_by && numbered_actor.number != 1
      numbered_actor.all_numbers
    end
  end

  def sequential_numbers
    if custom_instance_count
      1.upto(custom_instance_count).to_a
    end
  end

  private
    def lowercase_fields
      name.downcase! if name
    end

    def hostname_conflicts
      return unless network_interfaces.any?

      query = VirtualMachine
        .from(
          VirtualMachine
            .joins(:customization_specs)
            .select("virtual_machines.id, customization_specs.id as id2, coalesce(NULLIF(customization_specs.dns_name, ''), NULLIF(virtual_machines.name, '')) as composite_name")
            .where(id: (connection_nic&.network&.virtual_machine_ids || []) - [id])
        )
        .where('composite_name = ?', name)
        .exists?

      return unless query
      errors.add(:name, :hostname_conflict)
    end

    def transfer_overlap_error
      return unless custom_instance_count_changed?
      return unless addresses.each do |add|
        add.virtual_machine = self
        add.valid?
      end.any? { |a| a.errors.of_kind? :offset, :overlap }
      errors.add(:custom_instance_count, :invalid)
    end

    def invalidate_cache(_service)
      touch
    end

    def sync_host_spec_name
      return unless name_previously_changed?
      host_spec.update(name:)
    end

    def has_unnumbered_nets?
      networks.any? { |net| !net.numbered? }
    end

    def ensure_nic_status
      return if network_interface_ids.empty?
      NetworkInterface.transaction do
        network_interfaces.first.update(egress: true) if network_interfaces.egress.empty?
        if network_interfaces.connectable.empty?
          new_connection_address = addresses.joins(:address_pool).merge(AddressPool.scope_mgmt).first ||
            addresses.mode_ipv4_static.first ||
            addresses.mode_ipv6_static.first
          new_connection_address.update(connection: true) if new_connection_address
        end
      end
    end

    def create_default_spec
      customization_specs.first_or_create(mode: 'host', name:, user: system_owner)
    end

    def forced_numbered_by
      numbered_net = networks.detect(&:numbered?)
      if numbered_net && numbered_actor != numbered_net.actor.root
        errors.add(:numbered_by, :incoherent_numbering)
      end
    end
end
