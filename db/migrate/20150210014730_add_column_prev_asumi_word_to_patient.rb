class AddColumnPrevAsumiWordToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :prev_asumi_word, :integer, after: :prev_tweet_count
  end
end
