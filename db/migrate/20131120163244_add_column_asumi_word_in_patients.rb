class AddColumnAsumiWordInPatients < ActiveRecord::Migration[4.2]
  def up
    add_column :patients, :asumi_word,:integer, :default => nil, :after => :tweet_count
  end

  def down
    remove_column :patients, :asumi_word
  end
end
