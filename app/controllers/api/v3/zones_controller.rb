# frozen_string_literal: true

module API
  module V3
    class ZonesController < APIController
      before_action :get_exercise

      def index
        render json: {
          result: DNSZones.result_for(@exercise)
        }
      end
    end
  end
end
