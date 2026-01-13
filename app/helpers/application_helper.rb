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

  def sorted_tree_options(scope = authorized_scope(OperatingSystem.all))
    OrderedTree
      .result_for(scope)
      .map { |i| ["#{'-' * i.depth} #{i.name}", i.id] }
  end

  def actor_color_classes(actor)
    {
      slate: 'bg-slate-200 text-slate-800 hover:bg-slate-300 dark:bg-slate-700 dark:text-slate-300 dark:hover:bg-slate-800',
      amber: 'bg-amber-200 text-amber-800 hover:bg-amber-300 dark:bg-amber-700 dark:text-amber-300 dark:hover:bg-amber-800',
      emerald: 'bg-emerald-200 text-emerald-800 hover:bg-emerald-300 dark:bg-emerald-700 dark:text-emerald-300 dark:hover:bg-emerald-800',
      rose: 'bg-rose-200 text-rose-800 hover:bg-rose-300 dark:bg-rose-700 dark:text-rose-300 dark:hover:bg-rose-800',
      sky: 'bg-sky-200 text-sky-800 hover:bg-sky-300 dark:bg-sky-700 dark:text-sky-300 dark:hover:bg-sky-800',
      orange: 'bg-orange-200 text-orange-800 hover:bg-orange-300 dark:bg-orange-700 dark:text-orange-300 dark:hover:bg-orange-800',
      yellow: 'bg-yellow-200 text-yellow-800 hover:bg-yellow-300 dark:bg-yellow-400 dark:text-yellow-700 dark:hover:bg-yellow-800'
    }[(actor || Actor.new).ui_color.to_sym]
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

  def flat_hash(h)
    return [h] unless h.kind_of?(Hash)

    h.flat_map { |k, v| [k, flat_hash(v)] }.flatten
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
      case { controller_name:, action_name: }
      in controller_name: 'exercises'
        ContextualExerciseLinks::Component.new(exercise: @exercise)
      in controller_name: 'virtual_machines', action_name: 'index'
        ContextualInventory::Component.new(exercise: @exercise, filter_actor: @filter_actor)
      else
      end
    end
end
