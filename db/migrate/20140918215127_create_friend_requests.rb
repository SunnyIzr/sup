class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :requester_id
      t.integer :recipient_id
      t.boolean :accepted, default: false
    end
  end
end
