require 'rails_helper'

describe Ranker do
  it 'should rank a set of values based on size and freq in ASC order' do
    data = {:"1"=>6, :"2"=>6, :"3"=>15, :"4"=>13, :"5"=>11, :"6"=>12, :"7"=>13, :"8"=>9, :"9"=>5, :"10"=>14} 
    ranker = Ranker.new
    
    expect(ranker.rank(data.values)).to eq({5=>1, 6=>2, 9=>4, 11=>5, 12=>6, 13=>7, 14=>9, 15=>10})
  end
  it 'should rank a set of values based on size and freq in DESC order' do
    data = {:"1"=>6, :"2"=>6, :"3"=>15, :"4"=>13, :"5"=>11, :"6"=>12, :"7"=>13, :"8"=>9, :"9"=>5, :"10"=>14} 
    ranker = Ranker.new
    
    expect(ranker.rank(data.values,1)).to eq({15=>1, 14=>2, 13=>3, 12=>5, 11=>6, 9=>7, 6=>8, 5=>10})
  end
end