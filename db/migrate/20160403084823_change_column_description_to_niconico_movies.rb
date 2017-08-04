# frozen_string_literal: true

class ChangeColumnDescriptionToNiconicoMovies < ActiveRecord::Migration[4.2]
  def change
    change_column :niconico_movies, :description, :text
    change_column :niconico_populars, :description, :text
    change_column :today_niconicos, :description, :text
  end
end
