class CreateNewSerifs < ActiveRecord::Migration
  def change
    create_table :new_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
