class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :link
      t.boolean :used, default: false
      t.datetime :post_at

      t.timestamps
    end
  end
end
