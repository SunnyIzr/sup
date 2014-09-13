class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :weekday
      t.integer :start_hour
      t.integer :end_hour
    end
  end
end
