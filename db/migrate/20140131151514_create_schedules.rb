class CreateSchedules < ActiveRecord::Migration[4.2]
  def change
    create_table :schedules do |t|
      t.string :task
      t.datetime :time

      t.timestamps
    end
  end
end
