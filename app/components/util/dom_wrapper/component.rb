# frozen_string_literal: true

class Util::DomWrapper::Component < ApplicationViewComponent
  option :id, optional: true
  option :classes, optional: true, type: [proc(&:to_s)]

  private
    def html_classes = classes.join(' ')
end
