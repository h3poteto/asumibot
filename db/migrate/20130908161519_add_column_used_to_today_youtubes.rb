# frozen_string_literal: true

class AddColumnUsedToTodayYoutubes < ActiveRecord::Migration[4.2]
  def change
    add_column :today_youtubes, :used, :boolean, :default => 0, :null => false, :after => 'priority'
  end
end
