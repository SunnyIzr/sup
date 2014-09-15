# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Sup::Application.load_tasks

desc 'Seed Database with Traits'
task 'db:seed_traits' => :environment do
  CSV.foreach('seeds/traits.csv') do |row|
    Trait.create(description: row[0])
  end
  CSV.foreach('seeds/match_traits.csv') do |row|
    MatchTrait.create(description: row[0])
  end
end

desc 'Set Up New Database'
task 'db:setup' => :environment do
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed_traits"].invoke
end