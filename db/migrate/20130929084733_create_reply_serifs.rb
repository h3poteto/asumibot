class CreateReplySerifs < ActiveRecord::Migration
  def change
    create_table :reply_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
