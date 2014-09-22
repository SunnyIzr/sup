FactoryGirl.define do
  factory :game do
    title {'Titanfall'}
    platform {Platform.last.nil? ? FactoryGirl.create(:platform) : Platform.last}
  end
end
