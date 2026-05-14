# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  nilify_blanks types: [:text, :string]
  before_create :generate_uuid_v7

  def preload(*args)
    preloader = ActiveRecord::Associations::Preloader.new
    preloader.preload(self, *args)
  end

  private
    def generate_uuid_v7
      return if self.class.attribute_types['id'].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end
end
