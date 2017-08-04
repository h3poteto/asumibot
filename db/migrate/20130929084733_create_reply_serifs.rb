# frozen_string_literal: true

class CreateReplySerifs < ActiveRecord::Migration[4.2]
  def change
    create_table :reply_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
