class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = @user.friendships
  end
end