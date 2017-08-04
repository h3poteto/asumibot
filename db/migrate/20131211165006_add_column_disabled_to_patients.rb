# frozen_string_literal: true

class AddColumnDisabledToPatients < ActiveRecord::Migration[4.2]
  def change
    add_column :patients, :disabled, :boolean, null: false, default: 0, :after => :locked
  end
end
