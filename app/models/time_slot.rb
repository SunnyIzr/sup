class TimeSlot < ActiveRecord::Base
  validates_presence_of :weekday, :hour
  has_many :availabilities
  has_many :users, through: :availabilities
  WEEKDAY_NAMES=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
  def weekday_name
    WEEKDAY_NAMES[self.weekday]
  end
  def self.all_time_slots(schedule)
    time_slots = []
    schedule.each do |day,times|
      time_slots << time_slots(day,times['start_time'],times['end_time'])
    end
    time_slots.flatten!.compact!
  end
  def self.time_slots(day,start_time,end_time)
    unless start_time == ''
      weekday = WEEKDAY_NAMES.index(day.capitalize)
      TimeSlot.all.select{ |ts| ts.weekday == weekday && ts.hour >= start_time.to_i && ts.hour <= end_time.to_i }
    else 
      nil
    end
  end
end