class ChangeColumnProtectInPatient < ActiveRecord::Migration
  def change
    change_column :patients, :protect, :boolean, null: false, default: false
  end
end
