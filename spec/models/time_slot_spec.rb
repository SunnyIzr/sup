require 'rails_helper'

describe TimeSlot do
  it {should validate_presence_of (:weekday)}
  it {should validate_presence_of (:start_hour)}
  it {should validate_presence_of (:end_hour)}
end