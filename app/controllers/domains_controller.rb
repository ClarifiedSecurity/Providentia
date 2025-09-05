# frozen_string_literal: true

class DomainsController < ApplicationController
  before_action :get_exercise
  before_action :get_domain, only: %i[show update destroy]

  def new
    @domain = @exercise.domains.build
    authorize! @domain
  end

  def show; end

  def create
    @domain = @exercise.domains.build(domain_params)
    authorize! @domain
    if @domain.save
      flash.now[:notice] = 'Domain was successfully created.'
    else
      render :new, status: 400
    end
  end

  def update
    if @domain.update domain_params
      flash[:notice] = 'Domain was successfully updated.'
    else
      render :show, status: 400
    end
  end

  def destroy
    if @domain.destroy
      redirect_to [@exercise, :domains], notice: 'Domain was successfully destroyed.'
    else
      redirect_to [@exercise, :domains], flash: { error: @domain.errors.full_messages.join(', ') }
    end
  end

  private
    def domain_params
      params.require(:domain).permit(:name)
    end

    def get_domain
      @domain = @exercise.domains.find(params[:id])
      authorize! @domain
    end
end
