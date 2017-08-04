# frozen_string_literal: true

class ChangeColumnProtectInPatient < ActiveRecord::Migration[4.2]
  def change
    change_column :patients, :protect, :boolean, null: false, default: false
  end
end
