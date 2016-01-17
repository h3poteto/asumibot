class AddIndexTweetIdOnAsumiTweets < ActiveRecord::Migration
  def change
    add_index :asumi_tweets, :tweet_id, unique: true
  end
end
