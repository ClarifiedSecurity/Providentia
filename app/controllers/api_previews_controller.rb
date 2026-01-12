# frozen_string_literal: true

class APIPreviewsController < ApplicationController
  before_action :get_exercise, :generate_presenters

  def show
  end

  private
    def item
      @item ||= search_scope.find(params[:id])
    end

    def search_scope
      case params[:model]
      when 'virtual_machine'
        authorized_scope(@exercise.virtual_machines)
      when 'network'
        authorized_scope(@exercise.networks).friendly
      when 'capability'
        authorized_scope(@exercise.capabilities).friendly
      when 'service'
        authorized_scope(@exercise.services).friendly
      else
        raise ActionController::RoutingError, 'Not Found'
      end
    end

    def generate_presenters
      @presenters ||= case params[:model]
                      when 'virtual_machine'
                        item.customization_specs.map do |spec|
                          API::V3::CustomizationSpecPresenter.new(spec)
                        end
                      when 'network'
                        [API::V3::NetworkPresenter.new(item)]
                      when 'capability'
                        [API::V3::CapabilityPresenter.new(item)]
                      when 'service'
                        [API::V3::ServicePresenter.new(item, authorized_scope(@exercise.customization_specs))]
      end
    end
end
