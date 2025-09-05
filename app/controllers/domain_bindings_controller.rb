# frozen_string_literal: true

class DomainBindingsController < ApplicationController
  before_action :get_exercise, :get_network
  before_action :get_domain, only: %i[update]
  before_action :get_domain_binding, only: %i[update destroy]

  def create
    @domain_binding = @network.domain_bindings.build
    authorize! @domain_binding
    @domain_binding.domain = default_domain || create_domain_new_by_name
    @domain_binding.save
  end

  def update
    @domain_binding.domain = @domain
    @domain_binding.assign_attributes(domain_binding_params)
    @domain_binding.save
    render @domain_binding
  end

  def destroy
    @domain_binding.destroy
  end

  private
    def domain_binding_params
      params.require(:domain_binding).permit(:name)
    end

    def get_network
      @network = authorized_scope(@exercise.networks).friendly.find(params[:network_id])
      authorize! @network, to: :show?
    end

    def get_domain
      @domain = domain_scope || domain_scope(by: :name) || create_domain_new_by_name
      authorize! @domain, to: :show?
    end

    def domain_scope(by: :id)
      authorized_scope(@exercise.domains).find_by(
        Hash[by, params[:domain_binding][:domain_id]]
      ).tap do |d|
        authorize! d, to: :show? if d
      end
    end

    def default_domain
      @exercise.domains.first
    end

    def create_domain_new_by_name
      return if params.dig(:domain_binding, :domain_id).blank?
      @exercise.domains.build(name: params[:domain_binding][:domain_id]).tap do |domain|
        authorize! domain, to: :create?
        domain.save
      end
    end

    def get_domain_binding
      @domain_binding = authorized_scope(@network.domain_bindings).find(params[:id])
      authorize! @domain_binding
    end
end
