require 'rails_helper'

describe MatchAlgo do
  let (:user1) {FactoryGirl.create(:user)}
  
  it "should filter out prior matches from a given population based on given user's matches" do
    user1
    
    10.times {FactoryGirl.create(:user)}
    User.all[1..5].each do |user|
      Match.create(user: user1, matched_user_id: user.id)
    end
    expect(MatchAlgo.cut_prior_matches(user1,User.all[1..10]).map{|user| user.id}).to match_array(User.all[6..10].map{|user| user.id})
  end
  
  it "should filter out any matches that do not satisfy the minimum schedule overlap requirement (>=5) from a given population basd on a given user's mathces" do
    user1
    
    10.times {FactoryGirl.create(:user)}
    48.times { FactoryGirl.create(:time_slot)}
    5.times do |i|
      Availability.create(user: user1, time_slot: TimeSlot.all[i])
    end
    User.all[1..7].each do |user|
      10.times do
        Availability.create(user: user, time_slot: TimeSlot.all[5..47][rand(40)])
      end
    end
    User.all[8..10].each do |user|
      5.times do |i|
        Availability.create(user: user, time_slot: TimeSlot.all[i])
      end
    end    
  
    expect(MatchAlgo.filter_schedule_overlap_min(user1, User.all[1..10]).map{|user| user.id}).to match_array(User.all[8..10].map{|user| user.id})
  end
  
  it "should filter out any matches that do not satisfy the minimum trait/match_trait requirement (>=1) from a given population based on a given user's matches" do
    user1
    
    10.times {FactoryGirl.create(:user)}
    2.times{FactoryGirl.create(:trait)}
    2.times{FactoryGirl.create(:match_trait)}
    PlayerAttribute.create(user: user1, trait: Trait.last)
    MatchAttribute.create(user: user1, match_trait: MatchTrait.last)
    
    User.all[1..5].each do |user|
      PlayerAttribute.create(user: user, trait: Trait.first)
      MatchAttribute.create(user: user, match_trait: MatchTrait.first)
    end
    User.all[6..10].each do |user|
      PlayerAttribute.create(user: user, trait: Trait.last)
    end
    User.all[8..10].each do |user|
      MatchAttribute.create(user: user, match_trait: MatchTrait.last)
    end
    
    expect(MatchAlgo.filter_trait_min(user1,User.all[1..10]).map{|user|user.id}).to match_array(User.all[8..10].map{|user| user.id})
  end 
  
  it 'should return a suitable population of matches based on the following critical factors: 1. :game_ids MUST match 2. MUST NOT have been matched prior 3. schdules MUST overlap by min amt (5) 4. Traits & MatchTraits MUST overlap by min amt (1)' do
    user1
    
    20.times {FactoryGirl.create(:user)}
    2.times {FactoryGirl.create(:game)}
    user1.game = Game.last
    user1.save
    48.times { FactoryGirl.create(:time_slot)}
    5.times do |i|
      Availability.create(user: user1, time_slot: TimeSlot.all[i])
    end
    2.times{FactoryGirl.create(:trait)}
    2.times{FactoryGirl.create(:match_trait)}
    PlayerAttribute.create(user: user1, trait: Trait.last)
    MatchAttribute.create(user: user1, match_trait: MatchTrait.last)
    
    User.all[1..10].each do |user|
      user.game = Game.first
      user.save
    end
    User.all[11..20].each do |user|
      user.game = Game.last
      user.save
    end
    User.all[11..13].each do |user|
      Match.create(user: user1, matched_user_id: user.id)
    end 
    User.all[14..20].each do |user|
      10.times do
        Availability.create(user: user, time_slot: TimeSlot.all[5..47][rand(40)])
      end
    end
    User.all[16..20].each do |user|
      5.times do |i|
        Availability.create(user: user, time_slot: TimeSlot.all[i])
      end
      PlayerAttribute.create(user: user, trait: Trait.last)
      MatchAttribute.create(user: user, match_trait: MatchTrait.first)
    end
    User.all[19..20].each do |user|
      MatchAttribute.create(user: user, match_trait: MatchTrait.last)
    end

    expect(MatchAlgo.cut_prior_matches(user1,User.all[11..20]).map{|user| user.id}).to match_array(User.all[14..20].map{|user| user.id})
    expect(MatchAlgo.filter_schedule_overlap_min(user1, User.all[14..20]).map{|user| user.id}).to match_array(User.all[16..20].map{|user| user.id})
    expect(MatchAlgo.filter_trait_min(user1,User.all[16..20]).map{|user|user.id}).to match_array(User.all[19..20].map{|user| user.id})
    expect(MatchAlgo.get_suitable_pop(user1).map{|user|user.id}).to match_array(User.all[19..20].map{|user|user.id})    
  end
  
end