# frozen_string_literal: true

class ZonesController < ApplicationController
  before_action :get_exercise, :get_zones

  def index
  end

  private
    def get_zones
      @records = authorized_scope(@exercise.virtual_machines)
        .flat_map(&:customization_specs)
        .flat_map { SpecDNSRecords.result_for(it) }
    end
end
