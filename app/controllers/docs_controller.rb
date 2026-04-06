# frozen_string_literal: true

class DocsController < ApplicationController
  def show
    render Layout::Docs::Component.new(page: params[:page]), content_type: "text/html"
  end
end
