# frozen_string_literal: true

class CredentialBinding < ApplicationRecord
  belongs_to :credential_set
end
