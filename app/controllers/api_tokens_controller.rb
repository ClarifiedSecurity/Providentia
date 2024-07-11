# frozen_string_literal: true

class APITokensController < ApplicationController
  before_action :get_api_token, only: %i[destroy]

  def index
    @api_tokens = authorized_scope(current_user.api_tokens)
  end

  def new
    @api_token = current_user.api_tokens.build
  end

  def create
    @api_token = current_user.api_tokens.create(api_token_params)
  end

  def destroy
    authorize! @api_token
    @api_token.destroy

    redirect_to @api_token, notice: "#{APIToken.model_name.human} was successfully deleted."
  end

  private
    def api_token_params
      params.require(:api_token).permit(:name)
    end

    def get_api_token
      @api_token = authorized_scope(current_user.api_tokens).find(params[:id])
    end
end
