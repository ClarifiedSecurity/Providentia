# frozen_string_literal: true

class VersionsController < ApplicationController
  def index
    @versions = authorized_scope(Version.all)
      .order(created_at: :desc)
      .page(params[:page])

    authorize! @versions
  end

  def show
    @version = authorized_scope(Version.all).find(params[:id])
    authorize! @version
  end
end
