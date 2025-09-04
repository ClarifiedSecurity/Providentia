# frozen_string_literal: true

class ActorsController < ApplicationController
  before_action :get_exercise
  before_action :get_actor, except: %i[new create]

  def new
    @actor = @exercise.actors.build
    authorize! @actor
  end

  def create
    if params[:actor_id] && parent = authorized_scope(@exercise.actors).find(params[:actor_id])
      @actor = @exercise.actors.build(name: 'New sub-actor', abbreviation: 'new', parent:)
    else
      @actor = @exercise.actors.build(actor_params)
    end

    authorize! @actor
    @actor.save

    redirect_to [:edit, @exercise, @actor.root]
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
    @actor.role_bindings.delete_all
    @actor.destroy
    redirect_to @actor.parent ? [:edit, @exercise, @actor.root] : @exercise
  end

  private
    def get_actor
      @actor = authorized_scope(@exercise.actors).find(params[:id])
    end

    def actor_params
      params.require(:actor).permit(
        :name, :abbreviation, :description, :number,
        :parent_id, :default_visibility, :ui_color
      )
    end
end
