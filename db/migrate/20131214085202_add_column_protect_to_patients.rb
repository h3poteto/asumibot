# frozen_string_literal: true

class AddColumnProtectToPatients < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :protect, :boolean, :defautl => 0, :null => false, :after => "clear"
  end
end
