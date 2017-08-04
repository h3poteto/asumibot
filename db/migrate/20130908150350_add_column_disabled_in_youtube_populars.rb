class AddColumnDisabledInYoutubePopulars < ActiveRecord::Migration[4.2]
  def up
    add_column :youtube_populars, :disabled, :boolean, :default => 0, :null => false, :after => 'priority'
  end

  def down
    remove_column :youtube_populars, :disabled
  end
end
