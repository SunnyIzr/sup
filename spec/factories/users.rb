FactoryGirl.define do
  factory :user do
    username {"johndoe#{User.all.size.to_s}"}
    email {"test#{User.all.size.to_s}@test.com"}
    personal_rank {5}
    mic_style {5}
    play_style {5}
    desc_words ['fun','fast','unstoppable']
  end
end
