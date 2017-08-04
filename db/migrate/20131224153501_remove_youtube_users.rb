# frozen_string_literal: true

class RemoveYoutubeUsers < ActiveRecord::Migration[4.2]
  def up
    drop_table :youtube_users
  end

  def down
  end
end
