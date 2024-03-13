# frozen_string_literal: true

module SpecCacheUpdateBeforeDestroy
  extend ActiveSupport::Concern

  included do
    before_destroy ->(record) { UpdateServiceSpecCache.result_for(self) }
  end
end
