games = %w[Titanfall Battlefield Destiny Minecraft Halo FIFA NBA Plants Watch Duty]

FactoryGirl.define do
  factory :game do
    title {games[Game.all.size]}
    platform {Platform.last.nil? ? FactoryGirl.create(:platform) : Platform.last}
  end
end
