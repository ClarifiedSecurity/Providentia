# frozen_string_literal: true

class SearchesController < ApplicationController
  respond_to :turbo_stream

  def create
    if params[:query].present?
      @results = [
        authorized_scope(VirtualMachine.all)
          .joins(:exercise)
          .merge(Exercise.active)
          .search(params[:query])
          .limit(5),
        authorized_scope(Network.all)
          .joins(:exercise)
          .merge(Exercise.active)
          .search(params[:query])
          .limit(5),
        authorized_scope(OperatingSystem.all)
          .search(params[:query])
          .limit(5),
        authorized_scope(Exercise.all)
          .active
          .search(params[:query])
          .limit(5),
      ].flatten
    else
      @results = []
    end
  end
end
