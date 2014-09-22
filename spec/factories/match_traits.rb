descs = %w[a b c d e f g i j]
FactoryGirl.define do
  factory :match_trait do
    description {descs[MatchTrait.all.size]}
  end
end
