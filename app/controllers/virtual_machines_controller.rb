# frozen_string_literal: true

class VirtualMachinesController < ApplicationController
  include VmPage
  before_action :get_exercise
  before_action :get_virtual_machine, only: %i[update destroy]
  before_action :get_virtual_machine_for_show, only: %i[show]
  before_action :get_and_verify_submitted_actor, only: %i[create update]
  before_action :preload_form_collections, only: %i[new create show destroy]

  respond_to :turbo_stream

  def index
    @virtual_machines = authorized_scope(@exercise.virtual_machines)
      .includes({ customization_specs: [:capabilities, :tags] })
      .includes({ connection_nic: { addresses: [:address_pool] } })
      .preload(
        :actor, :numbered_by,
        :host_spec, :operating_system, :system_owner,
        connection_nic: [:addresses],
      )
      .order(:name)

    filter_by_actor
    filter_by_name
  end

  def new
    @virtual_machine = @exercise.virtual_machines.build
    authorize! @virtual_machine
  end

  def create
    @virtual_machine = @exercise.virtual_machines.build(
      params.require(:virtual_machine).permit(:name)
    )
    @virtual_machine.actor = @submitted_actor
    authorize! @virtual_machine

    if @virtual_machine.save
      redirect_to [@exercise, @virtual_machine], notice: 'Virtual machine was successfully created.'
    else
      render :new, status: 400
    end
  end

  def show
    preload_services
    authorize! @virtual_machine
  end

  def address_preview
    @virtual_machine ||= @exercise
      .virtual_machines
      .find(params[:id])

    authorize! @virtual_machine, to: :show?
  end

  def update
    @virtual_machine.numbered_by = get_numbered
    @virtual_machine.actor = @submitted_actor
    @virtual_machine.assign_attributes(virtual_machine_params)
    @virtual_machine.save

    preload_services
    preload_form_collections
  end

  def destroy
    @virtual_machine.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to [@exercise, :virtual_machines], notice: 'Virtual machine was successfully destroyed.' }
    end
  end

  private
    def get_virtual_machine
      @virtual_machine = @exercise.virtual_machines.find(params[:id])
      authorize! @virtual_machine
    end

    def get_virtual_machine_for_show
      @virtual_machine ||= @exercise
        .virtual_machines
        .includes(
            :actor,
            :operating_system,
            networks: [:exercise],
            network_interfaces: [{ addresses: [:network] }, { network: [:actor] }]
          )
        .find(params[:id])
    end

    def filter_by_actor
      return unless params[:actor].present?
      @filter_actor = authorized_scope(@exercise.actors).find_by(abbreviation: params[:actor])
      @virtual_machines = @virtual_machines.where(actor: @filter_actor)
    end

    def filter_by_name
      return unless params[:query].present?
      @virtual_machines = @virtual_machines.search(params[:query])
    end

    def virtual_machine_params
      params.require(:virtual_machine).permit(
        :name, :visibility,
        :system_owner_id, :description,
        :custom_instance_count,
        :operating_system_id, :cpu, :ram, :primary_disk_size,
      )
    end

    def get_numbered
      GlobalID::Locator.locate(params[:virtual_machine].extract!(:numbered_by)[:numbered_by]).tap do |numbered_by|
        return unless numbered_by
        authorize! numbered_by, to: :show?
      end
    end

    def get_and_verify_submitted_actor
      @submitted_actor = authorized_scope(@exercise.actors, as: :vm_dev).find_by(
        id: params[:virtual_machine].extract!(:actor_id)[:actor_id]
      )
    end
end
