# frozen_string_literal: true

require 'parameterized_tag_parser'

ActsAsTaggableOn.default_parser = ParameterizedTagParser

Rails.application.config.after_initialize do
  ActsAsTaggableOn::Tagging.class_eval do
    include SpecCacheUpdateOnSave
    include SpecCacheUpdateAfterDestroy
  end
end
