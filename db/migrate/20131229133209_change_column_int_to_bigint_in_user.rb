# frozen_string_literal: true

class ChangeColumnIntToBigintInUser < ActiveRecord::Migration[4.2]
  def up
    change_column :users, :twitter_id, :integer, :limit => 8
  end

  def down
    change_column :users, :twitter_id, :integer
  end
end
