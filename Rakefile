# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Sup::Application.load_tasks

desc 'Seed Database with Traits/Activities'
task 'db:seed_traits' => :environment do
  CSV.foreach('seeds/traits.csv') do |row|
    Trait.create(description: row[0])
  end
  CSV.foreach('seeds/match_traits.csv') do |row|
    MatchTrait.create(description: row[0])
  end
  CSV.foreach('seeds/outside_activities.csv') do |row|
    OutsideActivity.create(description: row[0])
  end
end

desc 'Seed Database with Games'
task 'db:seed_games' => :environment do
  CSV.foreach('seeds/platforms.csv') do |row|
    Platform.create(name: row[0])
  end
  CSV.foreach('seeds/games.csv') do |row|
    platform = Platform.find_by(name: row[1])
    game = Game.new(title:row[0])
    game.platform = platform
    game.save
  end
end

desc 'Seed Database with Time Slots'
task 'db:seed_times' => :environment do
  0.upto(6) do |weekday|
    0.upto(23) do |hour|
      TimeSlot.create(weekday: weekday, hour: hour)
    end
  end
end

desc 'Seed Database with Users'
task 'db:seed_users' => :environment do
  puts "Now seeding database with 10k users..."
  occupations = %w[Finance Technology Legal Science Medicine Hospitality Construction]
  10000.times do |i|
    Faker::Config.locale = 'en-US'
    u = User.new
    u.username = Faker::Internet.user_name
    u.email = Faker::Internet.email
    u.personal_rank = Random.rand(101)
    u.mic_style = Random.rand(101)
    u.play_style = Random.rand(101)
    u.desc_words = 3.times.map{ Faker::Lorem.word }
    u.date_of_birth = Faker::Date.birthday
    u.postal_code = Faker::Address.zip_code
    u.password = 'password'
    u.gamertag = Faker::Internet.user_name
    u.occupation = occupations.sample
    u.game = Game.limit(1).order("RANDOM()").first
    u.trait_ids = [*1..10].shuffle[0..(Random.rand(6) + 1)]
    u.match_trait_ids = [*1..10].shuffle[0..(Random.rand(6) + 1)]
    u.outside_activity_ids = [*1..20].shuffle[0..(Random.rand(10) + 1)]
    u.time_slot_ids = [*1..168].shuffle[0..25]
    u.save
    puts "User#{i+1} of 10,000 complete!"
  end
end

desc 'Set Up New Database'
task 'db:setup' => :environment do
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed_traits"].invoke
  Rake::Task["db:seed_games"].invoke
  Rake::Task["db:seed_times"].invoke
  Rake::Task["db:seed_users"].invoke
end