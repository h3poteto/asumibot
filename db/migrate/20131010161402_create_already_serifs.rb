# frozen_string_literal: true

class CreateAlreadySerifs < ActiveRecord::Migration[4.2]
  def change
    create_table :already_serifs do |t|
      t.string :word
      t.timestamps
    end
  end
end
