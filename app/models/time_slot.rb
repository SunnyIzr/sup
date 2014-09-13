class TimeSlot < ActiveRecord::Base
  validates_presence_of :weekday, :start_hour, :end_hour
end