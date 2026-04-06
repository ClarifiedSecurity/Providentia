# frozen_string_literal: true

require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class Layout::Docs::Component < ApplicationViewComponent
  class CustomRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  option :page

  private
    def markdown
      @@markdown ||= Redcarpet::Markdown.new(CustomRender,
        no_intra_emphasis:            true,
        fenced_code_blocks:           true,
        space_after_headers:          true,
        smartypants:                  true,
        disable_indented_code_blocks: true,
        prettify:                     true,
        tables:                       true,
        with_toc_data:                true,
        autolink:                     true
      )
    end

    def rendered_markdown
      ActionView::Base.annotate_rendered_view_with_filenames
      markdown.render(render(pick_page_component)).html_safe
    end

    def pick_page_component
      case page
      when 'api', 'templating'
        "Docs::#{page.classify}::Component".constantize.new
      else
        Docs::Unknown::Component.new
      end
    end
end
