class CreatePopularSerifs < ActiveRecord::Migration[4.2]
  def change
    create_table :popular_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
