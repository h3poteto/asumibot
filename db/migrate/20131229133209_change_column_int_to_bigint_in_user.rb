class ChangeColumnIntToBigintInUser < ActiveRecord::Migration
  def up
    change_column :users, :twitter_id, :integer, :limit => 8
  end

  def down
    change_column :users, :twitter_id, :integer
  end
end
