class AddColumnProtectToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :protect, :boolean, :defautl => 0, :null => false, :after => "clear"
  end
end
