descs = %w[a b c d e f g i j k]
FactoryGirl.define do
  factory :trait do
    description {descs[Trait.all.size]}
  end
end
