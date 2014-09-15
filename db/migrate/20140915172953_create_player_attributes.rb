class CreatePlayerAttributes < ActiveRecord::Migration
  def change
    create_table :player_attributes do |t|
      t.belongs_to :user
      t.belongs_to :trait
    end
  end
end
