require 'rails_helper'

describe FriendRequest do
  it {should belong_to (:requester)}
  it {should belong_to (:recipient)}
end