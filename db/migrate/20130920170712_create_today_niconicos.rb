# frozen_string_literal: true

class CreateTodayNiconicos < ActiveRecord::Migration[4.2]
  def change
    create_table :today_niconicos do |t|
      t.string :title
      t.string :url
      t.string :description
      t.boolean :priority
      t.boolean :used, :default => 0, :null => false

      t.timestamps
    end
  end
end
