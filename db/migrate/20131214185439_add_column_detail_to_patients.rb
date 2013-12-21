class AddColumnDetailToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :nickname, :string, :after => :name
    add_column :patients, :description, :text, :after => :nickname
    add_column :patients, :icon, :string, :after => :description
    add_column :patients, :all_tweet, :integer, :after => :icon
    add_column :patients, :friend, :integer, :after => :all_tweet
    add_column :patients, :follower, :integer, :after => :friend
  end
end
