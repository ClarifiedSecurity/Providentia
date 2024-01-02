# frozen_string_literal: true

PaperTrail.config.has_paper_trail_defaults = {
  on: %i[create update destroy],
  versions: { class_name: 'Version' }
}
