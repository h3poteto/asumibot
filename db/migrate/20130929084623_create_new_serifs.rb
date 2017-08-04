# frozen_string_literal: true

class CreateNewSerifs < ActiveRecord::Migration[4.2]
  def change
    create_table :new_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
