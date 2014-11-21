class FriendRequest < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  
  def accept!
    self.update!(accepted: true)
    Friendship.create(user: self.requester, friend: self.recipient)
    Friendship.create(user: self.recipient, friend: self.requester)
  end
  
  def decline!
    self.destroy
  end
end