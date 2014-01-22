class AddPrevTweetCountColumnInPatients < ActiveRecord::Migration
  def change
    add_column :patients, :prev_tweet_count,:integer, after: :prev_level
  end
end
