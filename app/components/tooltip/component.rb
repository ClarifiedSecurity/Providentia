# frozen_string_literal: true

class Tooltip::Component < ApplicationViewComponent
  param :object
  option :actor, optional: true, default: nil
  option :text, optional: true, default: nil

  def call
    LiquidReplacer.new(template_text).iterate do |variable_node|
      content_tag(
        :span,
        content_tag(
          :strong,
          "[ #{variable_node.name.name} ]",
          { data: { action: 'mouseenter->tooltip#show mouseleave->tooltip#hide' } }
        ),
        {
          class: 'contents',
          data: {
            controller: 'tooltip',
            tooltip: LiquidRangeSubstitution.result_for(@object, node: variable_node, actor:)
          }
        }
      )
    end.html_safe
  end

  private
    def template_text
      raise 'Implement me!'
    end
end
