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
  it {should validate_presence_of (:gamertag)}
  it {should validate_presence_of (:occupation)}
  it {should validate_presence_of (:game_id)}
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
  
  it 'should create 3 new matches from MatchAlgo' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    allow(MatchAlgo).to receive(:run).with(user).and_return([user2,user3,user4])
    user.generate_new_matches
    expect(user.matched_users).to match_array([user2,user3,user4])
  end
  
  it 'should return outstanding matches' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    allow(MatchAlgo).to receive(:run).with(user).and_return([user2,user3,user4])
    user.generate_new_matches
    match3 = Match.where(user: user, matched_user: user4).first
    match3.update!(ignored: true)
    
    expect(user.outstanding_matched_users).to match_array([user2,user3])
  end
end
