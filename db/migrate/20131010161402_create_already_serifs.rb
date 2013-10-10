class CreateAlreadySerifs < ActiveRecord::Migration
  def change
    create_table :already_serifs do |t|
      t.string :word
      t.timestamps
    end
  end
end
