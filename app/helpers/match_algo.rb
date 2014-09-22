# The MatcAlgo Module for providing THREE appropriate matches for a given user
# INPUTS: The Module will take in ONE instance of a User
# OUTPUTS: The module will return THREE instances of a User that will be appropriate matches for the inputted user


module MatchAlgo
  MIN_SCHED_OVERLAP = 5
  MIN_TRAIT_OVERLAP = 1
  MIN_MATCH_TRAIT_OVERLAP = 1
  ALGO_WEIGHT = {
    schedule_overlap: 0.1428,
    age_diff: 0.1428,
    traits: 0.1428,
    match_traits: 0.1428,
    personal_rank_diff: 0.1432,
    play_style_diff: 0.1428,
    mic_style_diff: 0.1428
  }
  extend self
  
  def run(user)
    # [match1,match2,match3]
    pop = get_suitable_pop(user)
    ranks = calc_ranks(user,pop)
    matches = calc_weighted_avg_ranks(user,ranks)
    matches.sort_by!{|match,rank| rank}.reverse!
    matches.keys[0..2]
  end
  
  def get_suitable_pop(user)
    pop = User.where(game_id: user.game.id) - [user]
    pop = cut_prior_matches(user,pop)
    pop = filter_schedule_overlap_min(user,pop)
    pop = filter_trait_min(user,pop)
    pop
  end
  
  def cut_prior_matches(user,pop)
    prior_matches = user.matched_users
    pop.select {|match| !prior_matches.include?(match)}
  end
  
  def filter_schedule_overlap_min(user,pop)
    time_slots = user.time_slots
    pop.select{|match| (time_slots & match.time_slots).size >= MIN_SCHED_OVERLAP}
  end
  
  def filter_trait_min(user,pop)
    traits = user.traits
    match_traits = user.match_traits
    pop.select do |match|
      (traits & match.traits).size >= MIN_TRAIT_OVERLAP && (match_traits & match.match_traits).size >= MIN_MATCH_TRAIT_OVERLAP 
    end
  end
  
  def calc_ranks(user,pop)
    # {match: {schedule_overlap: X, age_diff: X, traits: X, match_traits: X, personal_rank_diff: X, play_style_diff: X, mic_style_diff: X}}
    ranks = {}
    rankers = {}
    diffs_and_overlaps = calc_diffs_and_overlaps(user,pop)
    
    ALGO_WEIGHT.each do |factor, weight|
      rankers[factor] = Ranker.new.rank(diffs_and_overlaps[factor].values,1)
    end
        
    pop.each do |match|
      match_rank = {}
      ALGO_WEIGHT.each do |factor, weight|
        match_rank[factor] = rankers[factor][diffs_and_overlaps[factor][match]]
      end
      ranks[match] = match_rank
    end
    ranks
  end
  
  def calc_diffs_and_overlaps(user,pop)
    # {:schedule_overlap:{match1: 15, match2: 12, match3: 10...}, age_diff: {match1: X}...}
    diffs_and_overlaps = {
      schedule_overlap: {},
      age_diff: {},
      traits: {},
      match_traits: {},
      personal_rank_diff: {},
      play_style_diff: {},
      mic_style_diff: {}
    }
    pop.each do |match|
      diffs_and_overlaps[:schedule_overlap][match] = (user.time_slots & match.time_slots).size
      diffs_and_overlaps[:age_diff][match] = (user.date_of_birth - match.date_of_birth).to_i.abs
      diffs_and_overlaps[:traits][match] = (user.traits & match.traits).size
      diffs_and_overlaps[:match_traits][match] = (user.traits & match.traits).size
      diffs_and_overlaps[:personal_rank_diff][match] = (user.personal_rank - match.personal_rank).abs
      diffs_and_overlaps[:play_style_diff][match] = (user.play_style - match.play_style).abs
      diffs_and_overlaps[:mic_style_diff][match] = (user.mic_style - match.mic_style).abs
    end
    diffs_and_overlaps
  end
  
  def calc_weighted_avg_ranks(user,ranks)
    # {match: weighted_avg}
    matches = {}
    ranks.each do |match,match_ranks|
      weighted_products = []
      match_ranks.each do |factor,rank|
        weighted_products << ALGO_WEIGHT[factor] * rank
      end
      matches[match] = weighted_products.sum
    end
    matches
  end
end