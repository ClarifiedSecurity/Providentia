# frozen_string_literal: true

class Form::Toggle::Component < ApplicationViewComponent
  param :form
  option :field
  option :disabled, optional: true, default: false

  private
    def label
      form.object.class.human_attribute_name(field)
    end

    def id
      "#{dom_id(form.object)}_#{field}"
    end
end