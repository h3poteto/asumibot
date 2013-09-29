class CreateSerifs < ActiveRecord::Migration
  def change
    create_table :serifs do |t|
      t.string :type
      t.string :word

      t.timestamps
    end
  end
end
