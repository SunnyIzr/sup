class CreatePreferredActivities < ActiveRecord::Migration
  def change
    create_table :preferred_activities do |t|
      t.belongs_to :user
      t.belongs_to :outside_activity
    end
  end
end
