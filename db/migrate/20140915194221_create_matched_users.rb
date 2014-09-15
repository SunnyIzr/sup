class CreateMatchedUsers < ActiveRecord::Migration
  def change
    create_table :matched_users do |t|
      t.belongs_to :user
      t.belongs_to :match
    end
  end
end
