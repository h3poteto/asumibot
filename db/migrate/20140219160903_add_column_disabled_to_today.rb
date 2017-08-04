class AddColumnDisabledToToday < ActiveRecord::Migration[4.2]
  def change
    add_column :today_niconicos, :disabled, :boolean, default: false, after: :used
    add_column :today_youtubes, :disabled, :boolean, default: false, after: :used
  end
end
