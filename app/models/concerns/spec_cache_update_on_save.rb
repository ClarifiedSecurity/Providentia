# frozen_string_literal: true

module SpecCacheUpdateOnSave
  extend ActiveSupport::Concern

  included do
    around_save :update_service_subject_spec_cache_with_yield
  end

  private
    def update_service_subject_spec_cache_with_yield
      yield
      UpdateServiceSpecCache.result_for(self)
    end
end
