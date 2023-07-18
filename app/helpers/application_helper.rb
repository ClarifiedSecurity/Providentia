# frozen_string_literal: true

module ApplicationHelper
  def session_path(scope)
    new_user_session_path
  end

  def title(page_title)
    provide(:title) { page_title }
  end

  def link_for_model(model)
    return unless model

    case model
    when AddressPool
      [model.exercise, model.network]
    when NetworkInterface, Address, CustomizationSpec
      [model.exercise, model.virtual_machine]
    when Exercise
      [model]
    when OperatingSystem
      [model]
    when ServiceCheck, SpecialCheck
      [model.service.exercise, model.service]
    when Check, ServiceSubject
      [model.exercise, model.service]
    else
      [model.exercise, model]
    end
  end

  def tailwind_classes_for(flash_type)
    {
      notice: 'bg-green-400 border-l-4 border-green-700 text-white',
      error:   'bg-red-400 border-l-4 border-red-700 text-black',
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def address_modes
    Address.modes.keys.map do |mode|
      [I18n.t("address_modes.#{mode}"), mode]
    end
  end

  def pool_ip_families
    AddressPool.ip_families.keys.map do |family|
      [I18n.t("ip_families.#{family}"), family]
    end
  end

  def pool_scopes
    AddressPool.scopes.keys.map do |scope|
      [I18n.t("pool_scopes.#{scope}"), scope]
    end
  end

  def visibility_modes
    VirtualMachine.visibilities.keys.map do |mode|
      [I18n.t("visibility_modes.#{mode}"), mode]
    end
  end

  def ip_families
    ServiceCheck.ip_families.keys.map do |mode|
      [I18n.t("ip_families.#{mode}"), mode]
    end
  end

  def service_subject_types
    ServiceSubjectMatchCondition::VALID_TYPES.map do |type_klass|
      [type_klass.model_name.human, type_klass.to_s]
    end
  end

  def nic_tooltip(nic)
    [
      nic.network.name,
      nic.egress? ? 'egress' : nil,
      nic.connection? ? 'connection' : nil
    ].compact.join ', '
  end

  def sorted_os_options(collection = nil)
    OrderedOperatingSystems
      .result_for(policy_scope(OperatingSystem))
      .map { |i| ["#{'-' * i.depth} #{i.name}", i.id] }
  end

  def sidebar_cache_key
    [
      @exercise.cache_key_with_version,
      'sidebar',
      policy_scope(@exercise.virtual_machines).cache_key_with_version,
      policy_scope(@exercise.networks).cache_key_with_version,
      policy_scope(@exercise.services).cache_key_with_version,
      policy_scope(@exercise.capabilities).cache_key_with_version,
    ]
  end

  def providentia_version_string
    Rails.configuration.x.providentia_version
  end

  def deploy_modes
    @actors.select(&:numbering).map do |actor|
      [I18n.t('deploy_modes.actor', actor: actor.name), actor.id]
    end
  end

  def actor_color_classes(actor)
    color = actor&.prefs&.dig('ui_color') || 'gray'
    case color
    when 'yellow'
      "bg-#{color}-200 text-#{color}-800 dark:bg-#{color}-400 dark:text-#{color}-700"
    else
      "bg-#{color}-200 text-#{color}-800 dark:bg-#{color}-700 dark:text-#{color}-300"
    end
  end

  def subject_selector_scope(match_condition)
    case match_condition.matcher_type
    when 'CustomizationSpec'
      policy_scope(@exercise.customization_specs).select(:id, :name).order(:name).map do |spec|
        [spec.name, spec.id]
      end
    when 'Capability'
      policy_scope(@exercise.capabilities).select(:id, :name).order(:name).map do |cap|
        [cap.name, cap.id]
      end
    when 'Actor'
      policy_scope(@exercise.actors).select(:id, :name).order(:name).map do |actor|
        [actor.name, actor.id]
      end
    when 'OperatingSystem'
      sorted_os_options
    when 'Network'
      policy_scope(@exercise.networks).select(:id, :name).order(:name).map do |network|
        [network.name, network.id]
      end
    when 'ActsAsTaggableOn::Tagging'
      ActsAsTaggableOn::Tag.for_tenant("exercise_#{@exercise.id}").map do |tag|
        [tag.name] * 2
      end
    else
      []
    end
  end
end
