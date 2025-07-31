# frozen_string_literal: true

module ApplicationHelper
  FLASH_CLASSES = {
    notice: 'bg-green-400 border-l-4 border-green-700 text-white',
    error:  'bg-red-400 border-l-4 border-red-700 text-black',
    alert:  'bg-red-400 border-l-4 border-red-700 text-black'
  }.freeze

  def session_path(scope)
    new_user_session_path
  end

  def title(page_title)
    provide(:title) { page_title }
  end

  def add_button_text
    case controller_name
    when 'dashboard'
      'Add environment'
    else
      "Add #{controller_name.classify.constantize.model_name.human}"
    end
  end

  def link_for_model(model)
    return unless model

    case model
    when AddressPool
      [model.exercise, model.network]
    when NetworkInterface, Address, CustomizationSpec
      [model.exercise, model.virtual_machine]
    when Credential
      [model.credential_set.exercise, model.credential_set]
    when Exercise, OperatingSystem
      [model]
    when Check, ServiceSubject
      [model.exercise, model.service]
    else
      [model.exercise, model]
    end
  end

  def tailwind_classes_for(flash_type)
    FLASH_CLASSES.stringify_keys[flash_type.to_s] || flash_type.to_s
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
    Check.ip_families.keys.map do |mode|
      [I18n.t("ip_families.#{mode}"), mode]
    end
  end

  def service_subject_types
    ServiceSubjectMatchCondition::VALID_TYPES.map do |type_klass|
      case type_klass
      when Class
        [type_klass.model_name.human, type_klass.to_s]
      when String
        [I18n.t("service_subject_match_conditions.#{type_klass}"), type_klass]
      else
        [type_klass.to_s.humanize, type_klass.to_s]
      end
    end
  end

  def roles_for_select
    RoleBinding.roles.keys.map do |role|
      [I18n.t("roles.#{role}.name"), role]
    end
  end

  def nic_tooltip(nic)
    [
      nic.network.name,
      ('egress' if nic.egress?),
      ('connection' if nic.connection?)
    ].compact.join(', ')
  end

  def sorted_tree_options(scope = authorized_scope(OperatingSystem.all))
    OrderedTree
      .result_for(scope)
      .map { |i| ["#{'-' * i.depth} #{i.name}", i.id] }
  end

  def nav_cache_key
    [
      @exercise.cache_key_with_version,
      'nav',
      authorized_scope(@exercise.virtual_machines).cache_key_with_version,
      authorized_scope(@exercise.networks).cache_key_with_version,
      authorized_scope(@exercise.services).cache_key_with_version,
      authorized_scope(@exercise.capabilities).cache_key_with_version
    ]
  end

  def providentia_version_string
    Rails.configuration.x.providentia_version
  end

  def actor_color_classes(actor)
    color = (actor || Actor.new).ui_color
    case color
    when 'yellow'
      "bg-#{color}-200 text-#{color}-800 dark:bg-#{color}-400 dark:text-#{color}-700"
    else
      "bg-#{color}-200 text-#{color}-800 dark:bg-#{color}-700 dark:text-#{color}-300"
    end
  end

  def subject_selector_scope(match_condition)
    scope = case match_condition.matcher_type
            when 'CustomizationSpec'
              @exercise.customization_specs
            when 'Capability'
              @exercise.capabilities
            when 'Actor'
              @exercise.actors
            when 'OperatingSystem'
              OperatingSystem.all
            when 'Network'
              @exercise.networks
            when 'ActsAsTaggableOn::Tagging'
              return ActsAsTaggableOn::Tag.for_tenant("exercise_#{@exercise.id}").map { |tag| [tag.name] }
            when 'SpecMode'
              return CustomizationSpec.modes.keys.map { |it| [it.humanize, it] }
            else
              return []
    end

    process_scope(scope, match_condition.matcher_type)
  end

  private
    def process_scope(scope, matcher_type)
      case matcher_type
      when 'Actor', 'OperatingSystem'
        sorted_tree_options(authorized_scope(scope))
      else
        authorized_scope(scope).select(:id, :name).order(:name).map { |item| [item.name, item.id] }
      end
  end

    def ar_class_to_link_text(klass)
      i18n_plural = klass.model_name.human(count: 2)
      if i18n_plural == klass.model_name.human
        klass.model_name.human.pluralize
      else
        i18n_plural
      end
    end

  def select_contextual_menu_component
  end
end
