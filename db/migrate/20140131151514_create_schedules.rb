class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :task
      t.datetime :time

      t.timestamps
    end
  end
end
