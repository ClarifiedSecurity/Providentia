# frozen_string_literal: true

class LiquidTextComponent < LiquidTooltipSnippetComponent
  private
    def template_text
      options[:text]
    end
end
