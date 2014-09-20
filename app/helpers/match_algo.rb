# The MatcAlgo Module for providing THREE appropriate matches for a given user
# INPUTS: The Module will take in ONE instance of a User
# OUTPUTS: The module will return THREE instances of a User that will be appropriate matches for the inputted user


module MatchAlgo
  ALGO_WEIGHT = {
    :schedule_overlap = 
    :age_diff = 
    :traits = 
    :match_traits = 
    :play_style_diff = 
    :mic_style_diff = 
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
  end
  
  def calc_ranks(user,pop)
    # {match: {schedule_overlap: X, age_diff: X, traits: X, match_traits: X, play_style_diff: X, mic_style_diff: X}}
    ranks = {}
    pop.each do |match|
      match_rank = {}
      match_rank[:schedule_overlap] =
      match_rank[:age_diff] =
      match_rank[:traits] = 
      match_rank[:match_traits] = 
      match_rank[:play_style_diff] =
      match_rank[:mic_style_diff] = 
      ranks[match] = match_rank
    end
    ranks
  end
  
  def calc_weighted_avg_ranks(user,ranks)
    # {match: weighted_avg}
    
  end
end