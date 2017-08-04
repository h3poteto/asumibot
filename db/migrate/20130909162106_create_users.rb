# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.integer :twitter_id
      t.string :screen_name

      t.timestamps
    end
  end
end
