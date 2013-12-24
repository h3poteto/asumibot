class RemoveYoutubeUsers < ActiveRecord::Migration
  def up
    drop_table :youtube_users
  end

  def down
  end
end
