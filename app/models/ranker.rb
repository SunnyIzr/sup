class Ranker
  attr_reader :rankings
  def rank(values,order=-1)
    @rankings = rank_values(values,order)
  end
  
  def rank_values(values,order)
    counts = {}
    values.each do |value|
      counts[value] = values.count(value)
    end
    if order == 1
      sorted_values = counts.sort_by{|value,count| value}.reverse 
    else
      sorted_values = counts.sort_by{|value,count| value}
    end
    ranks = {}
    current_rank = 1
    sorted_values.each_with_index do |value_count,index|
      value = value_count[0]
      count = value_count[1]
      if index == 0
        ranks[value] = current_rank
      else
        prior_count = sorted_values[index-1][1]
        current_rank = current_rank + prior_count
        ranks[value] = current_rank
      end
    end
    ranks
  end
end