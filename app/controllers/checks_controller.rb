# frozen_string_literal: true

class ChecksController < ApplicationController
  before_action :get_exercise, :get_service
  before_action :get_check, only: %i[update destroy]
  include ServicePage

  respond_to :turbo_stream

  def create
    self_subject = CustomCheckSubject.find_by(base_class: 'CustomizationSpec', meaning: 'self')
    @check = @service.checks.build({
      source: self_subject,
      destination: self_subject
    })
    authorize! @check
    @check.save
  end

  def update
    if params[:cm]
      config_map_update
    else
      regular_update
    end
  end

  def destroy
    @check.destroy
  end

  private
    def check_params
      params.fetch(:check, {}).permit(
        :check_mode,
        :special_label,  :protocol, :ip_family, :port, :scored
      )
    end

    def get_service
      @service = authorized_scope(@exercise.services)
        .includes(:service_subjects)
        .friendly
        .find(params[:service_id])
    end

    def get_check
      @check = @service.checks.find(params[:id])
      authorize! @check
    end

    def get_directions
      params[:check].extract!(:source_gid, :destination_gid).permit!.to_h.values.map do |gid|
        GlobalID::Locator.locate(gid)
      end.each { authorize! _1, to: :show? }
    end

    def config_map_update
      @form = ConfigMapForm.new(@check, params[:cm])
      if @form.save
        render turbo_stream: turbo_stream.remove('config_map_errors')
      else
        render turbo_stream: turbo_stream.append(
          'config_map_form',
          FormErrorBoxComponent.new(@form, id: 'config_map_errors').render_in(view_context)
        )
      end
    end

    def regular_update
      source, destination = get_directions
      @check.assign_attributes(check_params)
      @check.source = source
      @check.destination = destination
      @check.save
    end
end
