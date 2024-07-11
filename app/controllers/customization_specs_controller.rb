# frozen_string_literal: true

class CustomizationSpecsController < ApplicationController
  include VmPage
  before_action :get_exercise, :get_virtual_machine
  before_action :preload_form_collections, :preload_services, only: %i[create update]
  before_action :get_customization_spec, only: %i[update destroy]
  before_action :get_and_verify_capability_ids, only: %i[update]

  respond_to :turbo_stream

  def create
    @customization_spec = @virtual_machine
      .customization_specs
      .create(mode: 'container', name: "spec-#{@virtual_machine.customization_specs.size}")
    authorize! @customization_spec
  end

  def update
    preload_services
    @customization_spec.assign_attributes(spec_params)
    @customization_spec.capability_ids = @permitted_capability_ids
    @customization_spec.save
  end

  def destroy
    @customization_spec.destroy unless @customization_spec.mode_host?
  end

  private
    def get_virtual_machine
      @virtual_machine = authorized_scope(@exercise.virtual_machines)
        .find(params[:virtual_machine_id])
    end

    def get_customization_spec
      @customization_spec = @virtual_machine.customization_specs.friendly.find(params[:id])
      authorize! @customization_spec
    end

    def spec_params
      params.require(:customization_spec).permit(
        :name, :dns_name, :role_name, :description, :tag_list, :cluster_mode
      )
    end

    def get_and_verify_capability_ids
      @permitted_capability_ids = authorized_scope(@exercise.capabilities).where(
        id: params[:customization_spec].extract!(:capability_ids)[:capability_ids]
      ).pluck(:id)
    end
end
