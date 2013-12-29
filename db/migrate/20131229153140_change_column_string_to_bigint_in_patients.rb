class ChangeColumnStringToBigintInPatients < ActiveRecord::Migration
  def up
    change_column :patients, :twitter_id, :integer, :limit => 8
  end

  def down
    change_column :patients, :twitter_id, :string
  end
end
