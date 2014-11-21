# This module is responsible for producing an array of sup request activity for a given user:
# - INPUT: an instance of a User model
# - OUTPUT: an array of hashes sorted by date
  # - HASH: {:date,:type,:matched_user,:accepted}

module FriendRequestActivity
  extend self
  def activity(user)
    activity = sent_activity(user) + inc_activity(user)
    activity.sort_by{ |fr| fr[:updated_at] }.reverse
  end
  
  def sent_activity(user)
    activity = []
    sent_friend_requests = user.requested_friend_requests
    sent_friend_requests.each do |friend_request|
      hash = {}
      hash[:date] = friend_request.updated_at
      hash[:type] = :sent
      hash[:matched_user] = friend_request.recipient
      hash[:accepted] = friend_request.accepted
      activity << hash 
    end
    activity
  end
  
  def inc_activity(user)
    activity = []
    received_friend_requests = user.incoming_friend_requests
    received_friend_requests.each do |friend_request|
      hash = {}
      hash[:date] = friend_request.updated_at
      hash[:type] = :received
      hash[:matched_user] = friend_request.requester
      hash[:accepted] = friend_request.accepted
      activity << hash 
    end
    activity
  end
end