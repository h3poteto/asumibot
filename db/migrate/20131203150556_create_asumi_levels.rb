class CreateAsumiLevels < ActiveRecord::Migration
  def change
    create_table :asumi_levels do |t|
      t.integer :patient_id
      t.integer :asumi_count
      t.integer :tweet_count
      t.integer :asumi_word

      t.timestamps
    end
  end
end
