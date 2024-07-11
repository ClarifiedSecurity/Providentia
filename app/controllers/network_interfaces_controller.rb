# frozen_string_literal: true

class NetworkInterfacesController < ApplicationController
  include VmPage
  before_action :get_exercise, :get_virtual_machine
  before_action :preload_form_collections, :preload_services
  before_action :get_network_interface, only: %i[destroy update]
  before_action :get_and_verify_submitted_network, only: %i[create update]

  respond_to :turbo_stream

  def new
    @network_interface = @virtual_machine.network_interfaces.build
    authorize! @network_interface
  end

  def create
    @network_interface = @virtual_machine.network_interfaces.build(network: @submitted_network)
    authorize! @network_interface
    @network_interface.save
    @virtual_machine.reload
  end

  def destroy
    @network_interface.destroy
  end

  def update
    @network_interface.assign_attributes(nic_params)
    @network_interface.network = @submitted_network
    @network_interface.save
    @virtual_machine.reload
  end

  private
    def nic_params
      params.require(:network_interface).permit(:egress)
    end

    def get_virtual_machine
      @virtual_machine = @exercise.virtual_machines.find(params[:virtual_machine_id])
      authorize! @virtual_machine, to: :show?
    end

    def get_network_interface
      @network_interface = @virtual_machine.network_interfaces.find(params[:id])
      authorize! @network_interface
    end

    def get_and_verify_submitted_network
      @submitted_network = authorized_scope(@exercise.networks).find_by(
        id: params[:network_interface].extract!(:network_id)[:network_id]
      )
    end
end
