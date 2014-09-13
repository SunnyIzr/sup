require 'rails_helper'

describe TimeSlot do
  it {should validate_presence_of (:weekday)}
  it {should validate_presence_of (:start_hour)}
  it {should validate_presence_of (:end_hour)}
  
  it 'should return day of the week' do
    time_slot = FactoryGirl.create(:time_slot)
    expect(time_slot.weekday_name).to eq('Sunday')
  end
end