# frozen_string_literal: true

class ActorNumberConfigsController < ApplicationController
  before_action :get_exercise, :get_actor
  before_action :get_config, only: %i[update destroy]

  respond_to :turbo_stream

  def create
    @config = @actor.actor_number_configs.build(name: 'New Config')
    authorize! @config
    @config.save
  end

  def update
    authorize! @actor
    if params[:cm]
      config_map_update
    else
      regular_update
    end
  end

  def destroy
    authorize! @actor
    @config.destroy
  end

  private
    def get_actor
      @actor = authorized_scope(@exercise.actors).find(params[:actor_id])
    end

    def get_config
      @config = @actor.actor_number_configs.find(params[:id])
      authorize! @config
    end

    def regular_update
      @config.update(config_params)
    end

    def config_params
      params.require(:actor_number_config).permit(
        :name, { matcher: [] }
      )
    end

    def config_map_update
      @form = ConfigMapForm.new(@config, params[:cm])
      if @form.save
        render turbo_stream: turbo_stream.remove('config_map_errors')
      else
        render turbo_stream: turbo_stream.append(
          helpers.dom_id(@config, 'config_map_form'),
          FormErrorBoxComponent.new(@form, id: 'config_map_errors').render_in(view_context)
        )
      end
    end
end
