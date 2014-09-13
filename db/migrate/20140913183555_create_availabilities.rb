class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.belongs_to :user
      t.belongs_to :time_slot
    end
  end
end
