# frozen_string_literal: true

class HeaderBreadcrumbComponent < ViewComponent::Base
  Dropdown = Data.define(:recents, :add_action) do
    def initialize(recents:, add_action: nil)
      super(recents:, add_action:)
    end
  end
  DropdownItem = Data.define(:name, :url)

  with_collection_parameter :breadcrumb_item

  attr_reader :breadcrumb_item, :iteration

  def initialize(breadcrumb_item:, breadcrumb_item_iteration:)
    @breadcrumb_item = breadcrumb_item
    @iteration = breadcrumb_item_iteration
  end

  private
    def root?
      breadcrumb_item == :root
    end

    def url
      case breadcrumb_item
      when :root
        root_path
      when Exercise
        exercise_path(breadcrumb_item)
      when Class
        polymorphic_path([exercise, breadcrumb_item.model_name.plural.to_sym])
      end
    end

    def icon
      if root?
        # Providentia logo
        content_tag(:svg, class: 'inline w-5 h-5 fill-current', xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 512 512') do
          content_tag(:path, nil, d: 'M415.803 268.9c23.204-29.203 35.807-65.119 35.807-102.975 0-44.32-17.259-85.987-48.598-117.326C371.672 17.259 330.005 0 285.685 0c-37.858 0-73.773 12.603-102.975 35.807L153.444 6.541a19.19 19.19 0 0 0-27.14 0c-87.885 87.885-87.885 230.882 0 318.766 39.361 39.361 90.806 62.332 146.052 65.523v29.047h-2.678c-40.188 0-72.884 32.719-72.884 72.907 0 10.599 8.593 19.217 19.192 19.217h154.733c10.599 0 19.192-8.617 19.192-19.217 0-40.188-32.696-72.907-72.884-72.907h-6.287V389.85c50.778-5.563 97.767-27.98 134.329-64.543 7.495-7.495 7.495-19.647 0-27.142L415.803 268.9zm-98.775 189.361c11.925 0 22.455 6.397 28.654 15.354h-104.66c6.199-8.956 16.729-15.354 28.656-15.354h47.35zm-31.343-105.416c-50.017 0-96.981-19.419-132.241-54.679-68.338-68.338-72.634-176.837-12.879-250.221L155.57 62.95c-23.204 29.202-35.805 65.119-35.805 102.975 0 44.319 17.259 85.987 48.598 117.326 31.337 31.339 73.005 48.598 117.325 48.598 37.858 0 73.773-12.602 102.975-35.805l15.007 15.007c-33.21 27.076-74.439 41.794-117.985 41.794zm90.184-96.738c-24.089 24.089-56.116 37.355-90.184 37.355-34.067 0-66.094-13.266-90.183-37.355s-37.355-56.117-37.355-90.184 13.266-66.095 37.355-90.184c24.089-24.088 56.116-37.355 90.183-37.355 34.068 0 66.095 13.267 90.184 37.355 24.089 24.089 37.355 56.116 37.355 90.184 0 34.067-13.266 66.095-37.355 90.184z')
        end
      elsif breadcrumb_item.is_a? Class
        content_tag(:i, nil, class: "fas fa-fw #{breadcrumb_item.to_icon} mx-1")
      end
    end

    def content
      return if root?
      case breadcrumb_item
      when Exercise
        breadcrumb_item.name
      when Class
        breadcrumb_item.model_name.human(count: 2)
      else
        breadcrumb_item.name
      end
    end

    def add_button
      case [breadcrumb_item, breadcrumb_item.to_s]
      in [Class, 'OperatingSystem']
        if helpers.allowed_to?(:create?, breadcrumb_item)
          url_for([:new, breadcrumb_item.model_name.singular.to_sym])
        end
      in [Class, *]
        if helpers.allowed_to?(:create?, breadcrumb_item.new(exercise:))
          url_for([:new, exercise, breadcrumb_item.model_name.singular.to_sym])
        end
      else
      end
    end

    def dropdown
      case [breadcrumb_item, breadcrumb_item.to_s]
      in [Exercise, *]
        Dropdown.new(
          recents: helpers.authorized_scope(Exercise.all).order(updated_at: :desc).limit(4).map do |exercise|
            DropdownItem.new(name: exercise.name, url: exercise_path(exercise))
          end,
          add_action: if helpers.allowed_to?(:create?, :exercise)
                        url_for([:new, :exercise])
                      end
        )
      in [Class, 'OperatingSystem']
        Dropdown.new(
          recents: helpers.authorized_scope(breadcrumb_item.all).order(updated_at: :desc).limit(4).map do |item|
            DropdownItem.new(name: item.name, url: polymorphic_path([item]))
          end
        )
      in [Class, *]
        Dropdown.new(
          recents: helpers.authorized_scope(breadcrumb_item.where(exercise:)).order(updated_at: :desc).limit(4).map do |item|
            DropdownItem.new(name: item.name, url: polymorphic_path([exercise, item]))
          end
        )
      else
      end
    end

    def exercise
      controller.instance_variable_get('@exercise')
    end
end
