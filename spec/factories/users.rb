FactoryGirl.define do
  factory :user do
    username {"johndoe#{User.all.size.to_s}"}
    email {"test#{User.all.size.to_s}@test.com"}
    personal_rank {5}
    mic_style {5}
    play_style {5}
    desc_words ['fun','fast','unstoppable']
    date_of_birth {Date.new(1980,1,1)}
    postal_code {'10001'}
    password {'password'}
    game {Game.last.nil? ? FactoryGirl.create(:game) : Game.last}
    gamertag {'johnnyd'}
    occupation {'Finance'}
  end
end
