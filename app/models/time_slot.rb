class TimeSlot < ActiveRecord::Base
  validates_presence_of :weekday, :hour
  has_many :availabilities
  has_many :users, through: :availabilities
  WEEKDAY_NAMES=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
  def weekday_name
    WEEKDAY_NAMES[self.weekday]
  end
end