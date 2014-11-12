require 'rails_helper'
require 'rake'

describe TimeSlot do
  it {should validate_presence_of (:weekday)}
  it {should validate_presence_of (:hour)}
  it {should have_many(:users)}
  
  it 'should return day of the week' do
    time_slot = FactoryGirl.create(:time_slot)
    expect(time_slot.weekday_name).to eq('Sunday')
  end
  it 'should return all time slots for specific day,start time and end time' do
    0.upto(6) do |weekday|
      0.upto(23) do |hour|
        TimeSlot.create(weekday: weekday, hour: hour)
      end
    end
    day = 'Monday'
    start_time = 6
    end_time = 18
    monday_time_slots = TimeSlot.where(weekday: 1)
    expect(TimeSlot.time_slots(day,start_time,end_time)).to match_array(monday_time_slots[6..18])
  end
  it 'should return all time slots for a full schedule' do
    0.upto(6) do |weekday|
      0.upto(23) do |hour|
        TimeSlot.create(weekday: weekday, hour: hour)
      end
    end
    schedule = {"monday"=>{"start_time"=>"6", "end_time"=>"18"}, "tuesday"=>{"start_time"=>"6", "end_time"=>"18"}, "wednesday"=>{"start_time"=>"", "end_time"=>""}, "thursday"=>{"start_time"=>"", "end_time"=>""}, "friday"=>{"start_time"=>"", "end_time"=>""}, "saturday"=>{"start_time"=>"", "end_time"=>""}, "sunday"=>{"start_time"=>"", "end_time"=>""} }
    
    time_slots = TimeSlot.all[30..42] + TimeSlot.all[54..66]
    expect(TimeSlot.all_time_slots(schedule)).to match_array(time_slots)
  end
end