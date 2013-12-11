class AddColumnDisabledToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :disabled, :boolean, null: false, default: 0, :after => :locked
  end
end
