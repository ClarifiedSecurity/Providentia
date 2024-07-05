# frozen_string_literal: true

class AddressesController < ApplicationController
  include VmPage
  before_action :get_exercise, :get_network_interface, :get_virtual_machine
  before_action :preload_form_collections, :preload_services
  before_action :get_address, only: %i[update destroy]

  respond_to :turbo_stream

  def create
    @address = @network_interface.addresses.build
    authorize! @address
    @address.save
  end

  def update
    @address_form = AddressForm.new(@address, params[:address])
    @address_form.save
  end

  def destroy
    @address.destroy
  end

  private
    def get_network_interface
      @network_interface = authorized_scope(@exercise.virtual_machines)
        .find(params[:virtual_machine_id])
        .network_interfaces
        .find(params[:network_interface_id])
    end

    def get_virtual_machine
      @virtual_machine = @network_interface.virtual_machine
    end

    def get_address
      @address = @network_interface.addresses.find(params[:id])
      authorize! @address
    end
end
