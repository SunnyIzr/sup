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
    pop = User.where(game_id: user.game.id)
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
    pop.each do |match|
      match_rank = {}
      match_rank[:schedule_overlap] = 
      match_rank[:age_diff] =
      match_rank[:traits] = 
      match_rank[:match_traits] = 
      match_rank[:personal_rank_diff] = 
      match_rank[:play_style_diff] =
      match_rank[:mic_style_diff] = 
      ranks[match] = match_rank
    end
    ranks
  end
  
  def rank_schedule_overlap(user,match,pop)
    
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