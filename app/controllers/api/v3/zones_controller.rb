# frozen_string_literal: true

module API
  module V3
    class ZonesController < APIController
      before_action :get_exercise

      def index
        result = authorized_scope(@exercise.networks).includes(:actor, domain_bindings: [:domain]).reduce({}) do |acc, network|
          acc.merge(NetworkDNSZones.result_for(network)) { |_, old, new| old + new }
        end

        render json: { result: }
      end
    end
  end
end
