# frozen_string_literal: true

class LiquidTooltipSnippetComponent < ViewComponent::Base
  attr_reader :options

  def initialize(options = {}, object:)
    @object = object
    @options = options
  end

  def call
    LiquidReplacer.new(template_text).iterate do |variable_node|
      content_tag(
        :div,
        content_tag(
          :strong,
          "[ #{variable_node.name.name} ]",
          { data: { action: "mouseenter->tooltip#show mouseleave->tooltip#hide" }}
        ),
        {
          class: 'contents',
          data: {
            controller: 'tooltip',
            tooltip: LiquidRangeSubstitution.result_for(@object, node: variable_node, actor: options[:actor])
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
