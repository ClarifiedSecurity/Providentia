# frozen_string_literal: true

class Layout::Header::ActionBar::Component < ApplicationViewComponent
  Modal = Data.define(:title, :url)
  Action = Data.define(:text, :icon, :url, :delete, :modal) do
    def initialize(text:, icon:, url:, delete: nil, modal: nil)
      super(text:, icon:, url:, delete:, modal:)
    end

    def html_parameters
      {
        class: 'inline-flex items-center justify-center px-2 py-1 gap-0.5 text-xs font-medium shadow-sm font-medium text-slate-700 bg-transparent hover:bg-slate-700 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white dark:border-white dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:bg-gray-700'
      }.merge(data_parameters)
    end

    def data_parameters
      if delete
        { data: { turbo_method: 'delete', turbo_confirm: "Are you sure you want to delete this #{delete}?" } }
      elsif modal
        { data: { action: 'click->dialog#open', dialog_target: 'trigger' } }
      else
        {}
      end
    end
  end

  ENABLED_CLASSES = [
    VirtualMachine,
    Network,
    Capability,
    Service
  ].freeze

  EDITABLE_CLASSES = [
    Network,
    Capability,
    Service
  ].freeze

  def initialize(item:)
    @item = item
  end

  def actions
    [
      edit,
      api_preview,
      delete
    ].compact
  end

  private
    def render?
      ENABLED_CLASSES.include?(@item.class) && actions.any?
    end

    def edit
      if EDITABLE_CLASSES.include?(@item.class) && helpers.allowed_to?(:update?, @item)
        Action.new(
          text: 'Edit', icon: 'fa-pen-to-square',
          url: edit_url
        )
      end
    end

    def api_preview
      Action.new(
        text: 'API Preview', icon: 'fa-code', url: 'javascript:;',
        modal: Modal.new(title: 'API Preview', url: "/api_preview/#{exercise.to_param}/#{@item.class.model_name.singular_route_key}/#{@item.to_param}")
      )
    end

    def delete
      if helpers.allowed_to?(:destroy?, @item)
        Action.new(
          text: 'Delete', icon: 'fa-times-circle',
          url: url_for([exercise, @item]),
          delete: @item.class.name.downcase
        )
      end
    end

    def edit_url
      case @item
      when VirtualMachine, Service
        url_for([exercise, @item])
      else
        url_for([:edit, exercise, @item])
      end
    end
end
