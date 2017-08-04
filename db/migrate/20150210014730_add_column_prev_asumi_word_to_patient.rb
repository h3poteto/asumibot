class AddColumnPrevAsumiWordToPatient < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :prev_asumi_word, :integer, after: :prev_tweet_count
  end
end
