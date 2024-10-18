class CredentialBinding < ApplicationRecord
  belongs_to :credential_set
  belongs_to :customization_spec
end
