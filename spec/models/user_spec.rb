require 'rails_helper'

describe User do
  it {should validate_presence_of (:username)}
  it {should validate_presence_of (:email)}
  it {should validate_presence_of (:personal_rank)}
  it {should validate_presence_of (:mic_style)}
  it {should validate_presence_of (:play_style)}
  it {should validate_presence_of (:desc_words)}
  it {should validate_presence_of (:date_of_birth)}
  it {should validate_presence_of (:postal_code)}
  it {should validate_uniqueness_of (:username)}
  it {should validate_uniqueness_of (:email)}
  it {should have_many(:time_slots)}
  it {should have_many(:traits)}
  it {should have_many(:match_traits)}
  it {should have_many(:outside_activities)}
  it {should belong_to (:game)}
  it {should have_many(:matches)}
  it {should have_many(:matched_users)}
  it {should have_many(:requested_friend_requests)}
  it {should have_many(:incoming_friend_requests)}
  it {should have_many(:friendships)}
  it {should have_many(:inverse_friendships)}
end
