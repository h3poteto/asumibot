class ChangeColumnDescriptionToNiconicoMovies < ActiveRecord::Migration
  def change
    change_column :niconico_movies, :description, :text
    change_column :niconico_populars, :description, :text
    change_column :today_niconicos, :description, :text
  end
end
