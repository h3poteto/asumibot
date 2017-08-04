# frozen_string_literal: true

class AddIndexTweetIdOnAsumiTweets < ActiveRecord::Migration[4.2]
  def change
    add_index :asumi_tweets, :tweet_id, unique: true
  end
end
