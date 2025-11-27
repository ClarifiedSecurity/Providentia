# frozen_string_literal: true

class ActorTree::Component < ApplicationViewComponent
  def initialize(tree:)
    @tree = tree
  end

  def render?
    @tree.any?
  end

  private
    def spacer_classes(node)
      "pl-#{(node.depth - 1) * 2} ml-#{(node.depth - 1) * 2}"
    end
end
