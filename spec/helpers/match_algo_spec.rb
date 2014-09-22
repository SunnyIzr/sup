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
  
  it 'should calculate all the diffs and overlaps of ranking factors' do
    user1
    48.times { FactoryGirl.create(:time_slot)}
    10.times do |i|
      Availability.create(user: user1, time_slot: TimeSlot.all[i])
    end
    10.times{FactoryGirl.create(:trait)}
    10.times{FactoryGirl.create(:match_trait)}
    5.times { |i| PlayerAttribute.create(user: user1, trait: Trait.all[i]) }
    5.times { |i| MatchAttribute.create(user: user1, match_trait: MatchTrait.all[i]) }
  
    schedule_overlaps = []
    dobs = []
    common_traits = []
    common_match_traits = []
    personal_ranks = []
    play_style = []
    mic_style = []
    CSV.foreach('spec/data/algo_user_data.csv', headers: true) do |row|
      schedule_overlaps << row['schedule_overlap'].to_i
      dobs << Date.parse(row['date_of_birth'])
      common_traits << row['common_traits'].to_i
      common_match_traits << row['common_match_traits'].to_i
      personal_ranks << row['personal_rank'].to_i
      play_style << row['play_style'].to_i
      mic_style << row['mic_style'].to_i
      user = FactoryGirl.create(:user,username: row['username'],date_of_birth: Date.parse(row['date_of_birth']), personal_rank: row['personal_rank'].to_i, play_style: row['play_style'].to_i, mic_style: row['mic_style'].to_i)
      0.upto(row['common_traits'].to_i-1) do |n|
        PlayerAttribute.create(user: user, trait: Trait.all[n])
      end
      0.upto(row['common_match_traits'].to_i-1) do |n|
        MatchAttribute.create(user: user, match_trait: MatchTrait.all[n])
      end
      0.upto(row['schedule_overlap'].to_i-1) do |n|
        Availability.create(user: user, time_slot: TimeSlot.all[n])
      end
    end
    pop = User.all - [user1]
    data = calc_diffs_and_overlaps(user1,pop)
    dobs.map!{|date| (user1.date_of_birth - date).to_i.abs}
    personal_ranks.map!{|rank| (user1.personal_rank - rank).abs}
    play_style.map!{|rank| (user1.play_style - rank).abs}
    mic_style.map!{|rank| (user1.mic_style - rank).abs}
    
    expect(data[:schedule_overlap].values).to eq(schedule_overlaps)
    expect(data[:age_diff].values).to match_array(dobs)
    expect(data[:traits].values).to eq(common_traits)
    expect(data[:match_traits].values).to eq(common_match_traits)
    expect(data[:personal_rank_diff].values).to eq(personal_ranks)
    expect(data[:play_style_diff].values).to eq(play_style)
    expect(data[:mic_style_diff].values).to eq(mic_style)
  end
  
  it 'should calculate rankings for all different factors per potential match' do
    user1
    48.times { FactoryGirl.create(:time_slot)}
    10.times do |i|
      Availability.create(user: user1, time_slot: TimeSlot.all[i])
    end
    10.times{FactoryGirl.create(:trait)}
    10.times{FactoryGirl.create(:match_trait)}
    5.times { |i| PlayerAttribute.create(user: user1, trait: Trait.all[i]) }
    5.times { |i| MatchAttribute.create(user: user1, match_trait: MatchTrait.all[i]) }
    ranks = {}
    CSV.foreach('spec/data/algo_user_data.csv', headers: true) do |row|
      user = FactoryGirl.create(:user,username: row['username'],date_of_birth: Date.parse(row['date_of_birth']), personal_rank: row['personal_rank'].to_i, play_style: row['play_style'].to_i, mic_style: row['mic_style'].to_i)
      0.upto(row['common_traits'].to_i-1) do |n|
        PlayerAttribute.create(user: user, trait: Trait.all[n])
      end
      0.upto(row['common_match_traits'].to_i-1) do |n|
        MatchAttribute.create(user: user, match_trait: MatchTrait.all[n])
      end
      0.upto(row['schedule_overlap'].to_i-1) do |n|
        Availability.create(user: user, time_slot: TimeSlot.all[n])
      end
      match_ranks = {}
      match_ranks[:schedule_overlap] = row['schedule_overlap_rank'].to_i
      match_ranks[:age_diff] = row['age_diff_rank'].to_i
      match_ranks[:traits] = row['traits_rank'].to_i
      match_ranks[:match_traits] = row['match_traits_rank'].to_i
      match_ranks[:personal_rank_diff] = row['person_rank_rank'].to_i
      match_ranks[:play_style_diff] = row['play_style_rank'].to_i
      match_ranks[:mic_style_diff] = row['mic_style_rank'].to_i
      ranks[User.last] = match_ranks
    end
    pop = User.all - [user1]
    
    expect(MatchAlgo.calc_ranks(user1,pop)).to eq(ranks)
  end
  
end