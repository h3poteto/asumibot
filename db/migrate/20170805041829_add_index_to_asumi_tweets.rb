class AddIndexToAsumiTweets < ActiveRecord::Migration[5.1]
  def change
    add_index :asumi_tweets, [:patient_id, :tweet_time]
  end
end
