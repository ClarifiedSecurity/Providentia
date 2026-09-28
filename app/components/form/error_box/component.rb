# frozen_string_literal: true

class Form::ErrorBox::Component < ApplicationViewComponent
  param :form_object
  option :id, optional: true

  def render? = @form_object.errors.any?
end
