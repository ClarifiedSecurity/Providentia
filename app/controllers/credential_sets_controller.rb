# frozen_string_literal: true

class CredentialSetsController < ApplicationController
  before_action :get_exercise
  before_action :get_credential_sets, only: %i[show update destroy]

  def index
    @credential_sets = authorized_scope(@exercise.credential_sets).order(:name)
  end

  def new
    @credential_set = @exercise.credential_sets.build
    authorize! @credential_set
  end

  def create
    @credential_set = @exercise.credential_sets.build(credential_set_params)
    authorize! @credential_set

    if @credential_set.save
      redirect_to [@credential_set.exercise, @credential_set], notice: 'Credential was successfully created.'
    else
      render :new, status: 400
    end
  end

  def show; end

  def update
    if @credential_set.update credential_set_params
      redirect_to [@credential_set.exercise, @credential_set], notice: 'Credential was successfully updated.'
    else
      render :show, status: 400
    end
  end

  def destroy
    if @credential_set.destroy
      redirect_to [@exercise, :credential_sets], notice: 'Credential was successfully destroyed.'
    else
      redirect_to [@exercise, :credential_set], flash: { error: @credential_set.errors.full_messages.join(', ') }
    end
  end

  private
    def credential_set_params
      params.require(:credential_set).permit(:name, :description, :network_id)
    end

    def get_credential_sets
      @credential_set = @exercise.credential_sets.friendly.find(params[:id])
      authorize! @credential_set
    end
end
