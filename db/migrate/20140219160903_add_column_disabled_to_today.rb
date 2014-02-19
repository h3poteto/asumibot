class AddColumnDisabledToToday < ActiveRecord::Migration
  def change
    add_column :today_niconicos, :disabled, :boolean, default: false, after: :used
    add_column :today_youtubes, :disabled, :boolean, default: false, after: :used
  end
end
