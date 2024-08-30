# frozen_string_literal: true

class ActorsController < ApplicationController
  before_action :get_exercise
  before_action :get_actor, except: %i[create]

  respond_to :turbo_stream

  def create
    @actor = @exercise.actors.build({
      name: 'New actor',
      abbreviation: 'na'
    })
    authorize! @actor

    if params[:actor_id] && parent = authorized_scope(@exercise.actors).find(params[:actor_id])
      @actor.parent = parent
    end

    @actor.save
  end

  def show
    @networks = authorized_scope(@actor.networks).order(:name)
    @virtual_machines = authorized_scope(@exercise.virtual_machines.where(actor: @actor.subtree_ids)).order(:name)
  end

  def edit
    authorize! @actor, to: :update?
  end

  def update
    authorize! @actor
    @actor.update(actor_params)
  end

  def destroy
    authorize! @actor
    @actor.destroy
  end

  private
    def get_actor
      @actor = authorized_scope(@exercise.actors).find(params[:id])
    end

    def actor_params
      params.require(:actor).permit(
        :name, :abbreviation, :description, :number,
        :parent_id, :default_visibility
      )
    end
end
