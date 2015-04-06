class CreateMonthRankings < ActiveRecord::Migration
  def change
    create_table :month_rankings do |t|
      t.integer :patient_id
      t.integer :level, default: 0

      t.timestamps null: false
    end
  end
end
