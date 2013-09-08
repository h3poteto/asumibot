class AddColumnUsedToTodayYoutubes < ActiveRecord::Migration
  def change
    add_column :today_youtubes, :used, :boolean, :default => 0, :null => false, :after => 'priority'
  end
end
