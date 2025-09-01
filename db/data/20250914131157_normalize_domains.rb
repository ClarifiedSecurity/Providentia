# frozen_string_literal: true

class NormalizeDomains < ActiveRecord::Migration[8.0]
  TWO_OR_MORE_HASHES = /##+/
  ONE_HASH = /#/
  NO_SPACES_LIQUID = /(?:{{(\S.*?\S)}})/

  def up
    Network.find_each do |network|
      network.domain&.gsub!(TWO_OR_MORE_HASHES, '{{ team_nr_str }})')
      network.domain&.gsub!(ONE_HASH, '{{ team_nr }})')
      network.cloud_id&.gsub!(TWO_OR_MORE_HASHES, '{{ team_nr_str }})')
      network.cloud_id&.gsub!(ONE_HASH, '{{ team_nr }})')
      network.domain&.gsub!(NO_SPACES_LIQUID, '{{ \1 }}')
      network.cloud_id&.gsub!(NO_SPACES_LIQUID, '{{ \1 }}')
      network.save!
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
