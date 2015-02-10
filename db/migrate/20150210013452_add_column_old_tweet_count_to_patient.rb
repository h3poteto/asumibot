class AddColumnOldTweetCountToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :prev_level_tweet, :integer, after: :prev_level
  end
end
