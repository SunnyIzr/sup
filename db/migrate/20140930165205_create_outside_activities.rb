class CreateOutsideActivities < ActiveRecord::Migration
  def change
    create_table :outside_activities do |t|
      t.string :description
    end
  end
end
