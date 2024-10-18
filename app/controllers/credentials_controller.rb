# frozen_string_literal: true

class CredentialsController < ApplicationController
  before_action :get_exercise, :get_credential_set
  before_action :get_credential, only: %i[show update destroy]

  respond_to :turbo_stream

  def new
    @credential = @credential_set.credentials.build
    authorize! @credential
  end

  def create
    @credential = @credential_set.credentials.build(credential_params)
    @credential.password = Credential.generate_password
    authorize! @credential
    @credential.save
  end

  def update
    if params[:cm]
      config_map_update
    elsif randomize_param.present?
      @credential.update(password: Credential.generate_password)
    else
      @credential.update(credential_params)
    end
  end

  def destroy
    @credential.destroy
  end

  def import
    parsed_creds = Psych.safe_load(params[:import_yaml], symbolize_names: true)
    Credential.transaction do
      parsed_creds[:credentials].each do |cred|
        next unless cred[:name].to_s.strip.present?
        cred in {password:}
        cred in {custom_fields: Hash => custom_fields}

        @credential_set.credentials
          .where(name: cred[:name].to_s.strip)
          .first_or_create(password: password || Credential.generate_password)
          .tap {
            _1.password = password if password
            _1.config_map.merge!(custom_fields) if custom_fields
          }
          .save
      end
    end
  rescue Psych::SyntaxError
    render status: 400
  end


  private
    def get_credential_set
      @credential_set = authorized_scope(@exercise.credential_sets).friendly.find(params[:credential_set_id])
    end

    def get_credential
      @credential = authorized_scope(@credential_set.credentials).find(params[:id])
      authorize! @credential
    end

    def randomize_param
      @randomize_param ||= params[:credential].extract!(:randomize_password)
    end

    def credential_params
      params.require(:credential).permit(:name, :password, :email_override, :username_override, :read_only)
    end

    def config_map_update
      @form = ConfigMapForm.new(@credential, params[:cm])
      if @form.save
        render turbo_stream: turbo_stream.remove('config_map_errors')
      else
        render turbo_stream: turbo_stream.append(
          helpers.dom_id(@credential, 'config_map_form'),
          FormErrorBoxComponent.new(@form, id: 'config_map_errors').render_in(view_context)
        )
      end
    end
end
