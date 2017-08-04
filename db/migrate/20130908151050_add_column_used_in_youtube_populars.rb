# frozen_string_literal: true

class AddColumnUsedInYoutubePopulars < ActiveRecord::Migration[4.2]
  def up
    add_column :youtube_populars, :used, :boolean, :default => 0, :null => false, :after => 'priority'
  end

  def down
    remove_column :youtube_populars, :used
  end
end
