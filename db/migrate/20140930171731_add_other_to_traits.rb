class AddOtherToTraits < ActiveRecord::Migration
  def change
    add_column :traits, :user_created, :boolean, default: false
    add_column :match_traits, :user_created, :boolean, default: false
    add_column :outside_activities, :user_created, :boolean, default: false
  end
end
