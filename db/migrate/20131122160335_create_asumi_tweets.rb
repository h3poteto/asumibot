class CreateAsumiTweets < ActiveRecord::Migration
  def change
    create_table :asumi_tweets do |t|
      t.integer :patient_id
      t.string :tweet
      t.string :tweet_id
      t.datetime :tweet_time, :null => false

      t.timestamps
    end
  end
end
