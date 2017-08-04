class CreateNiconicoMovies < ActiveRecord::Migration[4.2]
  def change
    create_table :niconico_movies do |t|
      t.string :title
      t.string :url
      t.string :description
      t.boolean :priority
      t.boolean :disabled, :default => 0, :null => false

      t.timestamps
    end
  end
end
