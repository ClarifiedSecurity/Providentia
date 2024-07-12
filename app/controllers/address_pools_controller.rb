# frozen_string_literal: true

class AddressPoolsController < ApplicationController
  before_action :get_exercise, :get_network
  before_action :get_address_pool, only: %i[update destroy]

  respond_to :turbo_stream

  def create
    @address_pool = @network.address_pools.build(name: "New addresspool #{@network.address_pools.size + 1}")
    authorize! @address_pool
    @address_pool.save
  end

  def update
    form = AddressPoolForm.new(@address_pool, params[:address_pool])
    form.save
  end

  def destroy
    @address_pool.destroy
  end

  private
    def get_network
      @network = authorized_scope(@exercise.networks)
        .friendly.find(params[:network_id])
    end

    def get_address_pool
      @address_pool = @network.address_pools.friendly.find(params[:id])
      authorize! @address_pool
    end
end
