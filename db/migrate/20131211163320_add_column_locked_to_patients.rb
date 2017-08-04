class AddColumnLockedToPatients < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :locked, :boolean, null: false, default: 0, :after => :clear
  end
end
