# frozen_string_literal: true

class AddIndexToAsumiTweets < ActiveRecord::Migration[5.1]
  def change
    add_index :asumi_tweets, %i(patient_id tweet_time)
  end
end
