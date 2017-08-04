# frozen_string_literal: true

class ChangeColumnStringToBigintInPatients < ActiveRecord::Migration[4.2]
  def up
    change_column :patients, :twitter_id, :integer, :limit => 8
  end

  def down
    change_column :patients, :twitter_id, :string
  end
end
