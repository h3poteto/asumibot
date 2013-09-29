class CreatePopularSerifs < ActiveRecord::Migration
  def change
    create_table :popular_serifs do |t|
      t.string :word

      t.timestamps
    end
  end
end
