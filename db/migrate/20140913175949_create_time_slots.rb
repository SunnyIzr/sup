class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :weekday
      t.integer :hour
    end
  end
end
