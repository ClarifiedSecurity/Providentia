# frozen_string_literal: true

class CredentialsController < ApplicationController
  before_action :get_exercise, :get_credential_set
  before_action :get_credential, only: %i[update destroy]

  respond_to :turbo_stream

  def new
    @credential = @credential_set.credentials.build
    authorize! @credential
  end

  def create
    @credential = @credential_set.credentials.build(credential_params)
    authorize! @credential
    @credential.save
  end

  def update
    @credential.update(credential_params)
  end

  def destroy
    @credential.destroy
  end

  private
    def get_credential_set
      @credential_set = authorized_scope(@exercise.credential_sets).friendly.find(params[:credential_set_id])
    end

    def get_credential
      @credential = authorized_scope(@credential_set.credentials).find(params[:id])
      authorize! @credential
    end

    def credential_params
      params.require(:credential).permit(:name, :password, :email_override, :username_override, :read_only)
    end
end