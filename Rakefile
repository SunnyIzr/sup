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

desc 'Set Up New Database'
task 'db:setup' => :environment do
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed_traits"].invoke
  Rake::Task["db:seed_games"].invoke
  Rake::Task["db:seed_times"].invoke
end