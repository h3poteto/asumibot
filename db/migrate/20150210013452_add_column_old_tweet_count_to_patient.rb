# frozen_string_literal: true

class AddColumnOldTweetCountToPatient < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :prev_level_tweet, :integer, after: :prev_level
  end
end
