class CreateSerifs < ActiveRecord::Migration[4.2]
  def change
    create_table :serifs do |t|
      t.string :type
      t.string :word

      t.timestamps
    end
  end
end
