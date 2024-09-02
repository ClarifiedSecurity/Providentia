# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :get_exercise
  before_action :get_service, only: %i[update destroy]

  include ServicePage

  def index
    @services = authorized_scope(@exercise.services)
      .includes(:checks)
      .order(:name)
  end

  def new
    @service = @exercise.services.build
    authorize! @service
  end

  def create
    @service = @exercise.services.build(service_params)
    authorize! @service

    if @service.save
      redirect_to [@service.exercise, @service], notice: 'Service was successfully created.'
    else
      render :new, status: 400
    end
  end

  def show
    @service = @exercise.services
      .includes(:service_subjects, { checks: [:source, :destination] })
      .friendly.find(params[:id])
    authorize! @service
  end

  def update
    if @service.update(service_params)
      redirect_to [@service.exercise, @service], notice: 'Service was successfully updated.'
    else
      render :show, status: 400
    end
  end

  def destroy
    if @service.destroy
      redirect_to [@exercise, :services], notice: 'Service was successfully destroyed.'
    else
      redirect_to [@exercise, :services], flash: { error: @service.errors.full_messages.join(', ') }
    end
  end

  private
    def service_params
      params.require(:service).permit(:name, :description)
    end

    def get_service
      @service = @exercise.services.friendly.find(params[:id])
      authorize! @service
    end
end
