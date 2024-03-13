# frozen_string_literal: true

module SpecCacheUpdateAfterDestroy
  extend ActiveSupport::Concern

  included do
    after_destroy ->(record) { UpdateServiceSpecCache.result_for(self) }
  end
end
