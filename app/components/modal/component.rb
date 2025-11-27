# frozen_string_literal: true

class Modal::Component < ApplicationViewComponent
  renders_one :body

  def initialize(header: nil, size: :large, only_body: false)
    @header = header
    @size = size
    @only_body = only_body
  end

  private
    def size_classes
      case @size
      when :fullscreen
        'h-screen w-full'
      when :small
        'max-h-screen w-full max-w-lg'
      else # including large
        'max-h-screen w-full max-w-5xl'
      end
    end

    def content_classes
      case @size
      when :fullscreen
        'h-full grow'
      end
    end

    def js_controller_name
      self.class.to_s.sub('Component', '').downcase
    end
end
