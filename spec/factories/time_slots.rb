FactoryGirl.define do
  factory :time_slot do
    weekday {TimeSlot.last.nil? ? 0 : TimeSlot.last.hour == 23 ? TimeSlot.last.weekday + 1 : TimeSlot.last.weekday}
    hour {TimeSlot.last.nil? ? 0 : TimeSlot.last.hour == 23 ? 0 : TimeSlot.last.hour + 1 }
  end
end
