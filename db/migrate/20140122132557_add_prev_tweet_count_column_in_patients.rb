# frozen_string_literal: true

class AddPrevTweetCountColumnInPatients < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :prev_tweet_count,:integer, after: :prev_level
  end
end
