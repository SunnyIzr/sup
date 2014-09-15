class CreateMatchAttributes < ActiveRecord::Migration
  def change
    create_table :match_attributes do |t|
      t.belongs_to :user
      t.belongs_to :match_trait
    end
  end
end
